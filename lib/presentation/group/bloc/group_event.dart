part of 'group_bloc.dart';

class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class UserEnteredGroupScreenEvent extends GroupEvent {}

class UserAcceptedInvitationEvent extends GroupEvent {
  final Invitation invitation;

  const UserAcceptedInvitationEvent({required this.invitation});
}

class UserRejectedInvitationEvent extends GroupEvent {
  final Invitation invitation;

  const UserRejectedInvitationEvent({required this.invitation});
}

class LeaveGroupButtonPressedEvent extends GroupEvent {}

class InviteUserButtonPressedEvent extends GroupEvent {
  final String email;

  const InviteUserButtonPressedEvent({required this.email});
}
