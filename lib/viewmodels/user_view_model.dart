import 'package:alarmle/services/core/conectivity_service.dart';
import 'package:alarmle/services/core/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alarmle/services/core/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alarmle/models/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class UserViewModel extends ChangeNotifier 
{
  final AuthService _auth = AuthService();
  final FirestoreService _firestore = FirestoreService();
  final ConnectivityService _connectivity = ConnectivityService();

  UserModel? _user;
  bool _isConnected = false;
  bool _hasPendingSync = false;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isConnected => _isConnected;
  bool get isLoggedIn => _auth.currentUser != null;
  bool get isGuest => _user?.uid == 'guest';
  bool get isLoading => _isLoading;
  String? get googlePhotoUrl => _auth.googlePhotoUrl;

  Future<void> init() async 
  {
    _isConnected = await _connectivity.isConnected;

    //escucha cambios de conectividad
    _connectivity.onConnectivityChanged.listen((connected) async 
    {
      _isConnected = connected;
      notifyListeners();

      //si volvio la conexion y hay sincronizacion pendiente
      if (connected && _hasPendingSync && isLoggedIn) 
      {
        await _syncToFirestore();
      }
    });

    //carga los datos locales primero
    await _loadFromLocal();

    //si hay sesion activa, realizar sincronizacion con firestore
    if (isLoggedIn) 
    {
      await _syncFromFirestore();
    }

    notifyListeners();
  }

  //carga local
  Future<void> _loadFromLocal() async 
  {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_data');
    final hasPending = prefs.getBool('pending_sync') ?? false;
    _hasPendingSync = hasPending;

    if (raw != null) 
    {
      _user = UserModel.fromLocal(jsonDecode(raw));
    } 
    else 
    {
      _user = UserModel.guest();
    }
  }

  //guardar de forma local
  Future<void> _saveToLocal({bool pendingSync = false}) async 
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(_user!.toLocal()));
    await prefs.setBool('pending_sync', pendingSync);
    _hasPendingSync = pendingSync;
  }

  //sincronizacion con firestore → local
  Future<void> _syncFromFirestore() async 
  {
    if (!_isConnected) return;

    final uid = _auth.currentUser!.uid;
    final localPhotoPath = _user?.photoPath;

    final remote = await _firestore.getUser(uid, localPhotoPath: localPhotoPath);

    if (remote != null) 
    {
      //si habia datos locales y el score local es mayor, actualizar firestore
      if (_hasPendingSync && (_user?.score ?? 0) > remote.score) 
      {
        remote.score = _user!.score;
        await _firestore.updateScore(uid, remote.score);
      }
      _user = remote;
    } 
    else 
    {
      //primera vez que se inicia sesion, guardar datos en firestore con datos locales
      final firebaseUser = _auth.currentUser!;
      _user = UserModel
      (
        uid: uid,
        name: _user?.name == 'Usuario' ? (firebaseUser.displayName ?? 'Usuario') : _user!.name,
        email: firebaseUser.email ?? '',
        score: _user?.score ?? 0,
        photoPath: _user?.photoPath,
      );
      await _firestore.saveUser(_user!);
    }

    await _saveToLocal(pendingSync: false);
  }

  //sincronizacion local hacia firestore
  Future<void> _syncToFirestore() async 
  {
    if (!isLoggedIn || !_isConnected || _user == null) return;
    await _firestore.saveUser(_user!);
    await _saveToLocal(pendingSync: false);
  }

  //inicio de sesion con google
  Future<String?> signInWithGoogle() async 
  {
    _isLoading = true;
    notifyListeners();

    try 
    {
      final credential = await _auth.signInWithGoogle();
      if (credential == null) return null;
      await _syncFromFirestore();
      notifyListeners();
      return null;
    } catch (e) 
    {
      return e.toString();
    } finally 
    {
      _isLoading = false;
      notifyListeners();
    }
  }

  //registro con correo
  Future<String?> registerWithEmail(String email, String password, String name) async 
  {
    _isLoading = true;
    notifyListeners();

    try 
    {
      final credential = await _auth.registerWithEmail(email, password);
      final uid = credential.user!.uid;

      _user = UserModel
      (
        uid: uid,
        name: name.isEmpty ? 'Usuario' : name,
        email: email,
        score: _user?.score ?? 0,
        photoPath: _user?.photoPath,
      );

      if (_isConnected) 
      {
        await _firestore.saveUser(_user!);
        await _saveToLocal(pendingSync: false);
      } 
      else 
      {
        await _saveToLocal(pendingSync: true);
      }

      notifyListeners();
      return 'verify_email'; 
    } on FirebaseAuthException catch (e) 
    {
      return _authError(e.code);
    } finally 
    {
      _isLoading = false;
      notifyListeners();
    }
  }

  //inicio de sesion con correo
  Future<String?> signInWithEmail(String email, String password) async 
  {
    _isLoading = true;
    notifyListeners();

    try 
    {
      await _auth.signInWithEmail(email, password);
      await _syncFromFirestore();
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) 
    {
      return _authError(e.code);
    } finally 
    {
      _isLoading = false;
      notifyListeners();
    }
  }

  //cierre de sesion
  Future<void> signOut() async 
  {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.remove('pending_sync');
    _user = UserModel.guest();
    _hasPendingSync = false;
    notifyListeners();
  }

  //cambiar nombre
  Future<void> updateName(String name) async 
  {
    if (_user == null) return;
    _user!.name = name;

    if (isLoggedIn && _isConnected) 
    {
      await _firestore.updateName(_user!.uid, name);
      await _saveToLocal(pendingSync: false);
    } 
    else 
    {
      await _saveToLocal(pendingSync: isLoggedIn);
    }
    notifyListeners();
  }

  //boton de prueba para aumentar puntaje
  Future<void> incrementScore() async 
  {
    if (_user == null) return;
    _user!.score++;

    if (isLoggedIn && _isConnected) 
    {
      await _firestore.updateScore(_user!.uid, _user!.score);
      await _saveToLocal(pendingSync: false);
    } 
    else 
    {
      await _saveToLocal(pendingSync: isLoggedIn);
    }
    notifyListeners();
  }

  //cambiar foto de manera local
  Future<void> pickPhoto() async 
  {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;

    _user!.photoPath = picked.path;
    await _saveToLocal(pendingSync: _hasPendingSync);
    notifyListeners();
  }

  //codigos de error
  String _authError(String code) 
  {
    switch (code) 
    {
      case 'email-already-in-use': return 'Este correo ya está registrado';
      case 'invalid-email':        return 'Correo inválido';
      case 'weak-password':        return 'La contraseña debe tener al menos 6 caracteres';
      case 'user-not-found':       return 'No existe una cuenta con este correo';
      case 'wrong-password':       return 'Contraseña incorrecta';
      case 'too-many-requests':    return 'Demasiados intentos, intenta más tarde';
      default:                     return 'Error: $code';
    }
  }
}