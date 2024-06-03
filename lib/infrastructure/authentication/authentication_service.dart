import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';

class AuthenticationService implements AuthenticationServiceAbstraction {
  final AuthenticationRepositoryAbstraction authenticationRepository;

  AuthenticationService({required this.authenticationRepository});

  @override
  Future<bool> signIn(SignInDto dto) async {
    var signInRes = await authenticationRepository.signIn(dto);
    if (signInRes?.isEmpty ?? true) {
      return false;
    }

    await authenticationRepository.saveAccessToken(signInRes!);

    return true;
  }

  @override
  Future<bool> signUp(SignUpDto dto) async {
    return await authenticationRepository.signUp(dto);
  }
}
