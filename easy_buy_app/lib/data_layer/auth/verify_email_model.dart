class EmailVerification {
  final String? email;
  final String? code;

  EmailVerification({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {'email': email, 'verification_code': code};
  }
}
