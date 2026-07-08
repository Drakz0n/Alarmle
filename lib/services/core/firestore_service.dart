import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alarmle/models/user_model.dart';

class FirestoreService 
{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const _collection = 'users';

  //crear o actualiazar informacion del usuario
  Future<void> saveUser(UserModel user) async 
  {
    await _db.collection(_collection).doc(user.uid).set
    (
      user.toFirestore(),
      SetOptions(merge: true), 
    );
  }

  //obtener usuario
  Future<UserModel?> getUser(String uid, {String? localPhotoPath}) async 
  {
    final doc = await _db.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc.data()!, localPhotoPath);
  }

  //actualizar nombre
  Future<void> updateName(String uid, String name) async 
  {
    await _db.collection(_collection).doc(uid).update({'name': name});
  }

  //actualizar puntaje
  Future<void> updateScore(String uid, int score) async 
  {
    await _db.collection(_collection).doc(uid).update({'score': score});
  }

  //obtener top 10 usuarios con mayor puntaje
  Future<List<UserModel>> getLeaderboard() async 
  {
    final snapshot = await _db.collection(_collection)
        .orderBy('score', descending: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc.data(), null))
        .toList();
  }

  //eliminar usuario
  Future<void> deleteUser(String uid) async 
  {
    await _db.collection(_collection).doc(uid).delete();
  }
}
