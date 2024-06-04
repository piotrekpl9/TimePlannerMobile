import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';

abstract class AuthenticationServiceAbstraction {
  Stream<AuthStatus> get authenticationState;
  Future<bool> signIn(SignInDto dto);
  Future<bool> signUp(SignUpDto dto);
  Future<void> signOut();
}
