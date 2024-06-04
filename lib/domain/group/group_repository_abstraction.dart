import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';

abstract class GroupRepositoryAbstraction {
  Future<Group?> createGroup(String groupName);
  Future<bool> inviteUserByEmail(String groupId, String email);
  Future<bool> acceptInvitation(String invitationId);
  Future<bool> rejectInvitation(String invitationId);
  Future<bool> cancelInvitation(String groupId, String invitationId);
  Future<bool> leaveGroup(String groupId);

  Future<Group?> readGroup();
  Future<List<Invitation>> readPendingInvitation();
  Future<List<Invitation>> readGroupInvitations();
  Future<List<Member>> readGroupMembers();

  Future<bool> deleteGroupMember(String groupId, String memberId);
  Future<bool> deleteGroup(String groupId);
}
