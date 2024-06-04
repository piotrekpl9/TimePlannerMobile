import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';

abstract class AuthenticationRepositoryAbstraction {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> removeAccessToken();
  Future<String?> signIn(SignInDto dto);
  Future<bool> signUp(SignUpDto dto);
}
