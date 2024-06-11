import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/group_repository.dart';
import 'package:time_planner_mobile/presentation/authentication/model/signin_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryAbstraction _authenticationRepository;
  final GroupRepositoryAbstraction _groupRepository;
  final AuthenticationServiceAbstraction _authenticationService;
  late StreamSubscription<AuthStatus> _authenticationStatusSubscription;

  AuthenticationBloc(
      {required AuthenticationRepositoryAbstraction authenticationRepository,
      required GroupRepositoryAbstraction groupRepository,
      required AuthenticationServiceAbstraction authenticationService})
      : _authenticationRepository = authenticationRepository,
        _groupRepository = groupRepository,
        _authenticationService = authenticationService,
        super(const AuthenticationState(authStatus: AuthStatus.unknown)) {
    on<ApplicationStarted>(_applicationStarted);
    on<SignInButtonPressed>(_signInPressed);
    on<SignOutButtonPressed>(_onSignOutButtonPresedse);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChaned);

    _authenticationStatusSubscription =
        authenticationService.authenticationState.listen(
      (event) {
        add(AuthenticationStatusChanged(status: event));
      },
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationStatusChaned(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(event.status));
  }

  void _onSignOutButtonPresedse(
      SignOutButtonPressed event, Emitter<AuthenticationState> emitter) async {
    await _authenticationService.signOut();
  }

  void _applicationStarted(
      ApplicationStarted event, Emitter<AuthenticationState> emitter) async {
    var token = await _authenticationRepository.getAccessToken();
    if (token?.isEmpty ?? true) {
      await _groupRepository.getGroup();
      emitter(state.copyWith(AuthStatus.unauthenticated));
      return;
    }

    emitter(state.copyWith(AuthStatus.authenticated));
  }

  void _signInPressed(
      SignInButtonPressed event, Emitter<AuthenticationState> emitter) async {
    var signInDto = SignInDto(
        password: event.signInData.password, email: event.signInData.email);
    await _authenticationService.signIn(signInDto);
  }
}
