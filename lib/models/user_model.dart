class UserModel 
{
  final String uid;
  String name;
  String email;
  int score;
  String? photoPath;

  UserModel
  ({
    required this.uid,
    required this.name,
    required this.email,
    this.score = 0,
    this.photoPath,
  });

  //firestore
  Map<String, dynamic> toFirestore() => 
  {
    'uid': uid,
    'name': name,
    'email': email,
    'score': score,
    'createdAt': DateTime.now().toIso8601String(),
  };

  factory UserModel.fromFirestore(Map<String, dynamic> json, String? localPhotoPath) => UserModel
  (
    uid: json['uid'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    score: json['score'] ?? 0,
    photoPath: localPhotoPath,
  );

  //local
  Map<String, dynamic> toLocal() => 
  {
    'uid': uid,
    'name': name,
    'email': email,
    'score': score,
    'photoPath': photoPath ?? '',
  };

  factory UserModel.fromLocal(Map<String, dynamic> json) => UserModel
  (
    uid: json['uid'] ?? 'local',
    name: json['name'] ?? 'Usuario',
    email: json['email'] ?? '',
    score: json['score'] ?? 0,
    photoPath: (json['photoPath'] as String).isEmpty ? null : json['photoPath'],
  );

  //perfil por defecto
  factory UserModel.guest() => UserModel
  (
    uid: 'guest',
    name: 'Usuario',
    email: '',
    score: 0,
  );
}