part of 'user_profile_bloc.dart';

class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserEnteredProfileScreenEvent extends UserProfileEvent {}

class UserChangePasswordPressed extends UserProfileEvent {
  final String oldPassword;
  final String newPassword;

  const UserChangePasswordPressed(
      {required this.oldPassword, required this.newPassword});
}
