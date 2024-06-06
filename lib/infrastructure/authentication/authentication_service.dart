import 'package:rxdart/subjects.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';

class AuthenticationService implements AuthenticationServiceAbstraction {
  final _controller = BehaviorSubject<AuthStatus>();
  final AuthenticationRepositoryAbstraction authenticationRepository;

  AuthenticationService({required this.authenticationRepository});

  @override
  Stream<AuthStatus> get authenticationState async* {
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<bool> signIn(SignInDto dto) async {
    try {
      var signInRes = await authenticationRepository.signIn(dto);
      if (signInRes?.isEmpty ?? true) {
        return false;
      }

      _controller.add(AuthStatus.authenticated);
      await authenticationRepository.saveAccessToken(signInRes!);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signUp(SignUpDto dto) async {
    return await authenticationRepository.signUp(dto);
  }

  @override
  Future<void> signOut() async {
    await authenticationRepository.removeAccessToken();
    _controller.add(AuthStatus.unauthenticated);
  }
}
