class Auth {
  final String? email;
  final String? password;

  Auth({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
  
}
