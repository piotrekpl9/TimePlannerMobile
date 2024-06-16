part of 'group_bloc.dart';

enum GroupBlocStatus { loading, init, idle, error }

class GroupState extends Equatable {
  final Group? group;
  final User? user;
  final List<Invitation> invitations;
  final GroupBlocStatus status;
  final GenericErrorDetails? error;
  const GroupState({
    required this.status,
    this.group,
    required this.invitations,
    this.user,
    this.error,
  });

  GroupState copyWith(
      {Group? group,
      GroupBlocStatus? status,
      List<Invitation>? invitations,
      GenericErrorDetails? error,
      User? user}) {
    return GroupState(
        invitations: invitations ?? this.invitations,
        status: status ?? this.status,
        user: user ?? this.user,
        error: error ?? this.error,
        group: group ?? this.group);
  }

  @override
  List<Object?> get props => [group, status, invitations, error];
}
