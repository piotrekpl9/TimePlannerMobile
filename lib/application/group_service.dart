import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/application/service_base.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/group/group_service_abstraction.dart';

class GroupService extends ServiceBase implements GroupServiceAbstraction {
  final GroupRepositoryAbstraction groupRepository;

  GroupService({required this.groupRepository});

  @override
  Future<Either<ServiceError, bool>> acceptInvitation(
      String invitationId) async {
    var result = await groupRepository.acceptInvitation(invitationId);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, bool>> cancelInvitation(
      String groupId, String invitationId) async {
    var result = await groupRepository.cancelInvitation(groupId, invitationId);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, Group>> createGroup(String groupName) async {
    var result = await groupRepository.createGroup(groupName);

    return handleGenericResponse<Group>(result);
  }

  @override
  Future<Either<ServiceError, bool>> deleteGroup(String groupId) async {
    var result = await groupRepository.deleteGroup(groupId);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, bool>> deleteGroupMember(
      String groupId, String memberId) async {
    var result = await groupRepository.deleteGroupMember(groupId, memberId);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, bool>> inviteUserByEmail(
      String groupId, String email) async {
    var result = await groupRepository.inviteUserByEmail(groupId, email);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, bool>> leaveGroup(
      String groupId, String invitationId) async {
    var result = await groupRepository.leaveGroup(groupId);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, bool>> rejectInvitation(
      String invitationId) async {
    var result = await groupRepository.rejectInvitation(invitationId);

    return handleGenericResponse<bool>(result);
  }
}
