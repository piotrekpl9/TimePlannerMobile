import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/group/group_service_abstraction.dart';

class GroupService implements GroupServiceAbstraction {
  final GroupRepositoryAbstraction groupRepository;

  GroupService({required this.groupRepository});

  @override
  Future<bool> acceptInvitation(String invitationId) async {
    return await groupRepository.acceptInvitation(invitationId);
  }

  @override
  Future<bool> cancelInvitation(String groupId, String invitationId) async {
    return await groupRepository.cancelInvitation(groupId, invitationId);
  }

  @override
  Future<Group?> createGroup(String groupName) async {
    return await groupRepository.createGroup(groupName);
  }

  @override
  Future<bool> deleteGroup(String groupId) async {
    return await groupRepository.deleteGroup(groupId);
  }

  @override
  Future<bool> deleteGroupMember(String groupId, String memberId) async {
    return await groupRepository.deleteGroupMember(groupId, memberId);
  }

  @override
  Future<bool> inviteUserByEmail(String groupId, String email) async {
    return await groupRepository.inviteUserByEmail(groupId, email);
  }

  @override
  Future<bool> leaveGroup(String groupId, String invitationId) async {
    return await groupRepository.leaveGroup(groupId);
  }

  @override
  Future<bool> rejectInvitation(String invitationId) async {
    return await groupRepository.rejectInvitation(invitationId);
  }
}
