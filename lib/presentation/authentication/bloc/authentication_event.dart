part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class ApplicationStarted extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthStatus status;

  AuthenticationStatusChanged({required this.status});
}

class SignInButtonPressed extends AuthenticationEvent {
  final SignInData signInData;

  SignInButtonPressed({required this.signInData});
}

class SignOutButtonPressed extends AuthenticationEvent {}
