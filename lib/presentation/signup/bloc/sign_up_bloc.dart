import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';
import 'package:time_planner_mobile/presentation/signup/signup_data.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationServiceAbstraction authenticationService;

  SignUpBloc({required this.authenticationService})
      : super(const SignUpState(status: SignUpStatus.idle)) {
    on<SignUpButtonPressed>(_signUpPressed);
  }

  void _signUpPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emitter) async {
    var signUpDto = SignUpDto(
        name: event.signUpData.name,
        email: event.signUpData.email,
        password: event.signUpData.password,
        surname: event.signUpData.surname);
    var result = await authenticationService.signUp(signUpDto);
    if (result) {
      emitter(const SignUpState(status: SignUpStatus.success));
    } else {
      emitter(const SignUpState(status: SignUpStatus.failure));
    }
    emitter(const SignUpState(status: SignUpStatus.idle));
  }
}
