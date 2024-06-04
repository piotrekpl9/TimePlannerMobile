part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpButtonPressed extends SignUpEvent {
  final SignUpData signUpData;

  SignUpButtonPressed({required this.signUpData});

  @override
  List<Object?> get props => [signUpData];
}
