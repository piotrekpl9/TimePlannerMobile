import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/generic_error_details.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class GroupRepository implements GroupRepositoryAbstraction {
  final HttpClient httpClient;

  GroupRepository({required this.httpClient});

  @override
  Future<Either<RepositoryError, bool>> acceptInvitation(
      String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/accept",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> rejectInvitation(
      String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/reject",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> cancelInvitation(
      String groupId, String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/cancel",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, Group>> createGroup(String groupName) async {
    try {
      var result = await httpClient.dio.post("api/group/create", data: {
        "name": groupName,
      });
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }
      var group = Group.fromJson(result.data);
      return Right(group);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> deleteGroup(String groupId) async {
    try {
      var result = await httpClient.dio.delete(
        "api/group/$groupId/delete",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> deleteGroupMember(
      String groupId, String memberId) async {
    try {
      var result = await httpClient.dio.delete(
        "api/group/$groupId/members/$memberId",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> inviteUserByEmail(
      String groupId, String email) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/$groupId/invitations/create",
        data: {
          "email": email,
        },
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> leaveGroup(String groupId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/$groupId/leave",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }

      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, Group>> getGroup() async {
    try {
      var result = await httpClient.dio.get(
        "api/group",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      var group = Group.fromJson(result.data);
      return Right(group);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, List<Invitation>>>
      getGroupInvitations() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/invitations",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      var output = <Invitation>[];
      for (var item in result.data) {
        output.add(Invitation.fromJson(item));
      }
      return Right(output);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, List<Member>>> getGroupMembers() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/members",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      var output = <Member>[];
      for (var item in result.data) {
        output.add(Member.fromJson(item));
      }
      return Right(output);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, List<Invitation>>>
      getPendingInvitation() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/pending-invitations",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }
      var output = <Invitation>[];
      for (var item in result.data) {
        var x = Invitation.fromJson(item);
        output.add(x);
      }

      return Right(output);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }
}
