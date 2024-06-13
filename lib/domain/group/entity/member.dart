import 'package:time_planner_mobile/domain/group/member_role.dart';

class Member {
  final String uuid;
  final String name;
  final String surname;
  final String email;
  final DateTime createdAt;
  final MemberRole role;
  Member({
    required this.uuid,
    required this.name,
    required this.surname,
    required this.email,
    required this.createdAt,
    required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      uuid: json['memberId'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'] ?? "",
      role: MemberRole.fromString(json['role'] ?? "basic"),
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
