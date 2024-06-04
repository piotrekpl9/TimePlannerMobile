class User {
  final String name;
  final String surname;
  final String email;
  final DateTime createdAt;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
