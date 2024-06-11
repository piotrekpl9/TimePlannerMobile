part of 'user_profile_bloc.dart';

enum UserProfileStatus {
  initial,
  loading,
  idle,
  loadingFailure,
  passwordUpdate,
  updateSuccess,
  updateFailure
}

class UserProfileState extends Equatable {
  final UserProfileStatus status;
  final User? user;
  const UserProfileState({
    required this.status,
    this.user,
  });

  UserProfileState copyWith(
      {UserProfileStatus? status, User? user, Group? group}) {
    return UserProfileState(status: status ?? this.status, user: user ?? user);
  }

  @override
  List<Object?> get props => [status, user];
}
