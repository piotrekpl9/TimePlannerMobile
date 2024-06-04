import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';

abstract class GroupServiceAbstraction {
  Future<Group> createGroup(String groupName);

  Future<bool> inviteUserByEmail(String groupId, String email);
  Future<bool> acceptInvitation(String invitationId);
  Future<bool> rejectInvitation(String invitationId);
  Future<bool> cancelInvitation(String groupId, String invitationId);
  Future<bool> leaveGroup(String groupId, String invitationId);

  Future<List<Member>> deleteGroupMember(String groupId, String memberId);
  Future<List<Member>> deleteGroup(String groupId);
}
