import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';

abstract class GroupRepositoryAbstraction {
  Future<Either<RepositoryError, Group>> createGroup(String groupName);
  Future<Either<RepositoryError, bool>> inviteUserByEmail(
      String groupId, String email);
  Future<Either<RepositoryError, bool>> acceptInvitation(String invitationId);
  Future<Either<RepositoryError, bool>> rejectInvitation(String invitationId);
  Future<Either<RepositoryError, bool>> cancelInvitation(
      String groupId, String invitationId);
  Future<Either<RepositoryError, bool>> leaveGroup(String groupId);

  Future<Either<RepositoryError, Group>> getGroup();
  Future<Either<RepositoryError, List<Invitation>>> getPendingInvitation();
  Future<Either<RepositoryError, List<Invitation>>> getGroupInvitations();
  Future<Either<RepositoryError, List<Member>>> getGroupMembers();

  Future<Either<RepositoryError, bool>> deleteGroupMember(
      String groupId, String memberId);
  Future<Either<RepositoryError, bool>> deleteGroup(String groupId);
}
