import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';

abstract class GroupServiceAbstraction {
  Future<Either<ServiceError, Group>> createGroup(String groupName);

  Future<Either<ServiceError, bool>> inviteUserByEmail(
      String groupId, String email);
  Future<Either<ServiceError, bool>> acceptInvitation(String invitationId);
  Future<Either<ServiceError, bool>> rejectInvitation(String invitationId);
  Future<Either<ServiceError, bool>> cancelInvitation(
      String groupId, String invitationId);
  Future<Either<ServiceError, bool>> leaveGroup(
      String groupId, String invitationId);

  Future<Either<ServiceError, bool>> deleteGroupMember(
      String groupId, String memberId);
  Future<Either<ServiceError, bool>> deleteGroup(String groupId);
}
