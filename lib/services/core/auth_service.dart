import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService 
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _googleInitialized = false;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //google sign
  Future<void> _ensureGoogleInitialized() async 
  {
    if (_googleInitialized) return;
    await _googleSignIn.initialize
    (
      serverClientId: '254860124463-sbm6pjqp81auu0vdh60m5ma0ipu7sajm.apps.googleusercontent.com',
    );
    _googleInitialized = true;
  }

  Future<UserCredential?> signInWithGoogle() async 
  {
    await _ensureGoogleInitialized();

    try 
    {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception('idToken nulo: revisa serverClientId o Google Play Services en el dispositivo');
      }

      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      return await _auth.signInWithCredential(credential);

    } on GoogleSignInException catch (e) 
    {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      print('GoogleSignInException: ${e.code} - ${e.description}');
      rethrow;
    } catch (e) 
    {
      print('Error inesperado en signInWithGoogle: $e');
      rethrow;
    }
  }

  //registro con correo
  Future<UserCredential> registerWithEmail(String email, String password) async 
  {
    final credential = await _auth.createUserWithEmailAndPassword
    (
      email: email,
      password: password,
    );
    await credential.user?.sendEmailVerification();
    return credential;
  }

  //inicio de sesión con correo
  Future<UserCredential> signInWithEmail(String email, String password) async 
  {
    return await _auth.signInWithEmailAndPassword
    (
      email: email,
      password: password,
    );
  }

  Future<void> resendVerificationEmail() async 
  {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> reloadUser() async 
  {
    await _auth.currentUser?.reload();
  }
  
  //cerrar sesion
  Future<void> signOut() async 
  {
    await _ensureGoogleInitialized();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;
  String? get googlePhotoUrl => _auth.currentUser?.photoURL;
}