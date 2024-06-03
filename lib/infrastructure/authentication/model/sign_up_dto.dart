class SignUpDto {
  String name;
  String surname;
  String email;
  String password;

  SignUpDto({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
      };

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return SignUpDto(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
    );
  }
}
