part of 'sign_up_bloc.dart';

enum SignUpStatus { success, idle, failure }

class SignUpState extends Equatable {
  final SignUpStatus status;
  const SignUpState({required this.status});

  @override
  List<Object> get props => [status];
}
