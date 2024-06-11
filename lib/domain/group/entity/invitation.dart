import 'package:time_planner_mobile/domain/group/entity/member.dart';

enum InvitationStatus {
  pending,
  accepted,
  rejected,
  expired;

  static InvitationStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return InvitationStatus.pending;
      case 'accepted':
        return InvitationStatus.accepted;
      case 'rejected':
        return InvitationStatus.rejected;
      case 'expired':
        return InvitationStatus.expired;
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }
}

class Invitation {
  final String invitationId;
  final String targetEmail;
  final String groupName;
  final Member creator;
  final InvitationStatus status;
  final DateTime createdAt;

  Invitation({
    required this.invitationId,
    required this.groupName,
    required this.targetEmail,
    required this.creator,
    required this.status,
    required this.createdAt,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'],
      groupName: json['groupName'],
      targetEmail: json['targetEmail'],
      creator: Member.fromJson(json['creator']),
      status: InvitationStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'targetEmail': targetEmail,
      'groupName': groupName,
      'creator': creator.toJson(),
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
