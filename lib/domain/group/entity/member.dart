class Member {
  final String uuid;
  final String name;
  final String surname;
  final String email;
  final DateTime createdAt;

  Member({
    required this.uuid,
    required this.name,
    required this.surname,
    required this.email,
    required this.createdAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      uuid: json['memberId'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'] ?? "",
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': uuid,
      'name': name,
      'surname': surname,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
