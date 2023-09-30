class UserModel{
  final String email;
  final String password;
   String ? id;

//<editor-fold desc="Data Methods">
   UserModel({
    required this.email,
    required this.password,
     this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          id == other.id);

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' email: $email,' +
        ' password: $password,' +
        ' id: $id,' +
        '}';
  }

  UserModel copyWith({
    String? email,
    String? password,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'id': this.id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}