part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class ApplicationStarted extends AuthenticationEvent {}

class SignInButtonPressed extends AuthenticationEvent {
  final SignInData signInData;

  SignInButtonPressed({required this.signInData});
}
