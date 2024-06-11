import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepositoryAbstraction _groupRepository;
  GroupBloc({required GroupRepositoryAbstraction groupRepository})
      : _groupRepository = groupRepository,
        super(const GroupState(status: GroupBlocStatus.init, invitations: [])) {
    on<UserEnteredGroupScreenEvent>(_onScreenEnter);
    on<UserAcceptedInvitationEvent>(_userAcceptedInvitation);
    on<UserRejectedInvitationEvent>(_userRejectedInvitation);
    on<LeaveGroupButtonPressedEvent>(_leaveGroupButtonPressed);
  }

  void _onScreenEnter(
      UserEnteredGroupScreenEvent event, Emitter<GroupState> emitter) async {
    var group = await _groupRepository.getGroup();
    var invitations = await _groupRepository.getPendingInvitation();

    emitter(GroupState(
        status: GroupBlocStatus.idle, group: group, invitations: invitations));
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
}
