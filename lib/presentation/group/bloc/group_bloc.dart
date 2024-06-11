import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepositoryAbstraction _groupRepository;
  GroupBloc({required GroupRepositoryAbstraction groupRepository})
      : _groupRepository = groupRepository,
        super(const GroupState(status: GroupBlocStatus.init, invitations: [])) {
    on<UserEnteredGroupScreenEvent>(_onScreenEnter);
  }

  void _onScreenEnter(
      UserEnteredGroupScreenEvent event, Emitter<GroupState> emitter) async {
    var group = await _groupRepository.getGroup();
    var invitations = await _groupRepository.getPendingInvitation();
    emitter(state.copyWith(
        status: GroupBlocStatus.idle, group: group, invitations: invitations));
  }
}
