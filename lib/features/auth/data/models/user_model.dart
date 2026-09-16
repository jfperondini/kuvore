class UserModel {
  const UserModel({
    required this.uid,
    required this.name,
    required this.cpf,
    required this.email,
  });

  final String uid;
  final String name;
  final String cpf;
  final String email;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? '',
      name: map['name'] as String? ?? 'Usuário',
      cpf: map['cpf'] as String? ?? '',
      email: map['email'] as String? ?? '',
    );
  }
}
