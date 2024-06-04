class SignInDto {
  final String password;
  final String email;

  SignInDto({required this.password, required this.email});

  factory SignInDto.fromJson(Map<String, dynamic> json) {
    return SignInDto(
      password: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
      };
}
