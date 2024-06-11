part of 'group_bloc.dart';

enum GroupBlocStatus { loading, init, idle }

class GroupState extends Equatable {
  final Group? group;
  final List<Invitation> invitations;
  final GroupBlocStatus status;
  const GroupState(
      {required this.status, this.group, required this.invitations});

  GroupState copyWith(
      {Group? group, GroupBlocStatus? status, List<Invitation>? invitations}) {
    return GroupState(
        invitations: invitations ?? this.invitations,
        status: status ?? this.status,
        group: group ?? this.group);
  }

  @override
  List<Object?> get props => [group, status, invitations];
}
