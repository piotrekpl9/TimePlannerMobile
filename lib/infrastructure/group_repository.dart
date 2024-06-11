import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class GroupRepository implements GroupRepositoryAbstraction {
  final HttpClient httpClient;

  GroupRepository({required this.httpClient});

  @override
  Future<bool> acceptInvitation(String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/accept",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> rejectInvitation(String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/reject",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> cancelInvitation(String groupId, String invitationId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/invitations/$invitationId/cancel",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Group?> createGroup(String groupName) async {
    try {
      var result = await httpClient.dio.post("api/group/create", data: {
        "name": groupName,
      });
      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }
      var group = Group.fromJson(result.data);
      return group;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteGroup(String groupId) async {
    try {
      var result = await httpClient.dio.delete(
        "api/group/$groupId/delete",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteGroupMember(String groupId, String memberId) async {
    try {
      var result = await httpClient.dio.delete(
        "api/group/$groupId/members/$memberId",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> inviteUserByEmail(String groupId, String email) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/$groupId/invitations/create",
        data: {
          "email": email,
        },
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> leaveGroup(String groupId) async {
    try {
      var result = await httpClient.dio.post(
        "api/group/$groupId/leave",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Group?> getGroup() async {
    try {
      var result = await httpClient.dio.get(
        "api/group",
      );

      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }
      var group = Group.fromJson(result.data);
      return group;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Invitation>> getGroupInvitations() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/invitations",
      );

      if (result.statusCode != 200) {
        return [];
      }
      if (result.data == null) {
        return [];
      }
      var output = <Invitation>[];
      for (var item in result.data) {
        output.add(Invitation.fromJson(item));
      }
      return output;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Member>> getGroupMembers() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/members",
      );

      if (result.statusCode != 200) {
        return [];
      }
      if (result.data == null) {
        return [];
      }
      var output = <Member>[];
      for (var item in result.data) {
        output.add(Member.fromJson(item));
      }
      return output;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Invitation>> getPendingInvitation() async {
    try {
      var result = await httpClient.dio.get(
        "api/group/pending-invitations",
      );

      if (result.statusCode != 200) {
        return [];
      }
      if (result.data == null) {
        return [];
      }
      var output = <Invitation>[];
      for (var item in result.data) {
        var x = Invitation.fromJson(item);
        output.add(x);
      }
      return output;
    } catch (e) {
      return [];
    }
  }
}
