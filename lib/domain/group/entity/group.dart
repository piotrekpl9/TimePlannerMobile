import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';

class Group {
  final String groupId;
  final List<Invitation> invitations;
  final List<Member> members;
  final String name;
  final DateTime createdAt;
  final Member creator;

  Group({
    required this.groupId,
    required this.invitations,
    required this.members,
    required this.name,
    required this.createdAt,
    required this.creator,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      invitations: (json['invitations'] as List)
          .map((i) => Invitation.fromJson(i))
          .toList(),
      members:
          (json['members'] as List).map((m) => Member.fromJson(m)).toList(),
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      creator: Member.fromJson(json['creator']),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'invitations': invitations.map((i) => i.toJson()).toList(),
      'members': members.map((m) => m.toJson()).toList(),
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'creator': creator.toJson(),
    };
  }
}
