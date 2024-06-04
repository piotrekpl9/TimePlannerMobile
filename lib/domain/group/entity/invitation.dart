import 'package:time_planner_mobile/domain/group/entity/member.dart';

enum InvitationStatus { pending, accepted, rejected, expired }

class Invitation {
  final String invitationId;
  final String targetEmail;
  final Member creator;
  final InvitationStatus status;
  final DateTime createdAt;

  Invitation({
    required this.invitationId,
    required this.targetEmail,
    required this.creator,
    required this.status,
    required this.createdAt,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'],
      targetEmail: json['targetEmail'],
      creator: Member.fromJson(json['creator']),
      status: InvitationStatus.values.firstWhere(
          (e) => e.toString() == 'InvitationStatus.${json['status']}'),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'targetEmail': targetEmail,
      'creator': creator.toJson(),
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
