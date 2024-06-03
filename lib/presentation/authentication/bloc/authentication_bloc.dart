import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/presentation/authentication/model/signin_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryAbstraction authenticationRepository;
  final AuthenticationServiceAbstraction authenticationService;

  AuthenticationBloc(
      {required this.authenticationRepository,
      required this.authenticationService})
      : super(const AuthenticationState(authStatus: AuthStatus.unknown)) {
    on<ApplicationStarted>(_applicationStarted);
    on<SignInButtonPressed>(_signInPressed);
  }

  void _applicationStarted(
      ApplicationStarted event, Emitter<AuthenticationState> emitter) async {
    var token = await authenticationRepository.getAccessToken();
    if (token?.isEmpty ?? true) {
      emitter(state.copyWith(AuthStatus.unauthenticated));
      return;
    }

    emitter(state.copyWith(AuthStatus.authenticated));
  }

  void _signInPressed(
      SignInButtonPressed event, Emitter<AuthenticationState> emitter) async {
    var signInDto = SignInDto(
        password: event.signInData.password, email: event.signInData.email);
    var result = await authenticationService.signIn(signInDto);
    if (result) {
      emitter(state.copyWith(AuthStatus.authenticated));
      return;
    }

    emitter(state.copyWith(AuthStatus.unauthenticated));
  }
}
