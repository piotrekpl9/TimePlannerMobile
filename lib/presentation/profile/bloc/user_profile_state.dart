part of 'user_profile_bloc.dart';

enum UserProfileStatus {
  initial,
  loading,
  idle,
  loadingFailure,
  passwordUpdate,
  updateSuccess,
  updateFailure,
  error
}

class UserProfileState extends Equatable {
  final UserProfileStatus status;
  final User? user;
  final GenericErrorDetails? error;
  const UserProfileState({
    this.error,
    required this.status,
    this.user,
  });

  UserProfileState copyWith({
    UserProfileStatus? status,
    User? user,
    Group? group,
    GenericErrorDetails? error,
  }) {
    return UserProfileState(
        status: status ?? this.status,
        user: user ?? user,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, user, error];
}
