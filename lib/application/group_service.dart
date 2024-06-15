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
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> cancelInvitation(
      String groupId, String invitationId) async {
    var result = await groupRepository.cancelInvitation(groupId, invitationId);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, Group>> createGroup(String groupName) async {
    var result = await groupRepository.createGroup(groupName);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> deleteGroup(String groupId) async {
    var result = await groupRepository.deleteGroup(groupId);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> deleteGroupMember(
      String groupId, String memberId) async {
    var result = await groupRepository.deleteGroupMember(groupId, memberId);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> inviteUserByEmail(
      String groupId, String email) async {
    var result = await groupRepository.inviteUserByEmail(groupId, email);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> leaveGroup(
      String groupId, String invitationId) async {
    var result = await groupRepository.leaveGroup(groupId);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }

  @override
  Future<Either<ServiceError, bool>> rejectInvitation(
      String invitationId) async {
    var result = await groupRepository.rejectInvitation(invitationId);
    if (result.isLeft) {
      return handleError(result.left);
    }
    return Right(result.right);
  }
}
