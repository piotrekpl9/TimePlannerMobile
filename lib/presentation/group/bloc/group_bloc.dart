import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/group/group_service_abstraction.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepositoryAbstraction _groupRepository;
  final UserRepositoryAbstraction _userRepository;
  final GroupServiceAbstraction _groupService;
  GroupBloc(
      {required GroupRepositoryAbstraction groupRepository,
      required UserRepositoryAbstraction userRepository,
      required GroupServiceAbstraction groupService})
      : _groupRepository = groupRepository,
        _userRepository = userRepository,
        _groupService = groupService,
        super(const GroupState(status: GroupBlocStatus.init, invitations: [])) {
    on<UserEnteredGroupScreenEvent>(_onScreenEnter);
    on<UserAcceptedInvitationEvent>(_userAcceptedInvitation);
    on<UserRejectedInvitationEvent>(_userRejectedInvitation);
    on<LeaveGroupButtonPressedEvent>(_leaveGroupButtonPressed);
    on<InviteUserButtonPressedEvent>(_inviteButtonPressed);
    on<DeleteMemberButtonPressed>(_deleteMemberButtonPressed);
    on<CreateGroupButtonPressed>(_createGroup);
  }

  void _onScreenEnter(
      UserEnteredGroupScreenEvent event, Emitter<GroupState> emitter) async {
    var group = await _groupRepository.getGroup();
    var user = await _userRepository.getCurrentUser();
    var invitations = await _groupRepository.getPendingInvitation();

    emitter(GroupState(
        status: GroupBlocStatus.idle,
        group: group,
        invitations: invitations,
        user: user));
  }

  void _userAcceptedInvitation(
      UserAcceptedInvitationEvent event, Emitter<GroupState> emitter) async {
    var result =
        await _groupRepository.acceptInvitation(event.invitation.invitationId);
    if (result) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }

  void _userRejectedInvitation(
      UserRejectedInvitationEvent event, Emitter<GroupState> emitter) async {
    var result =
        await _groupRepository.rejectInvitation(event.invitation.invitationId);
    if (result) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }

  void _leaveGroupButtonPressed(
      LeaveGroupButtonPressedEvent event, Emitter<GroupState> emitter) async {
    if (state.group == null) {
      return;
    }
    var result = await _groupRepository.leaveGroup(state.group!.groupId);
    if (result) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }

  void _inviteButtonPressed(
      InviteUserButtonPressedEvent event, Emitter<GroupState> emitter) async {
    if (state.group == null) {
      return;
    }
    var result = await _groupRepository.inviteUserByEmail(
        state.group!.groupId, event.email);
    if (result) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }

  void _deleteMemberButtonPressed(
      DeleteMemberButtonPressed event, Emitter<GroupState> emitter) async {
    if (state.group == null || event.memberUUID.isEmpty) {
      return;
    }
    var result = await _groupService.deleteGroupMember(
        state.group!.groupId, event.memberUUID);
    if (result) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }

  void _createGroup(
      CreateGroupButtonPressed event, Emitter<GroupState> emitter) async {
    if (state.group != null || event.groupName.isEmpty) {
      return;
    }
    var result = await _groupService.createGroup(event.groupName);
    if (result != null) {
      add(UserEnteredGroupScreenEvent());
    } else {
      emitter(state.copyWith(status: GroupBlocStatus.idle));
    }
  }
}
