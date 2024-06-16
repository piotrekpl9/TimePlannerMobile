import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/common/generic_error_details.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserServiceAbstraction _userService;
  final UserRepositoryAbstraction _userRepository;

  UserProfileBloc({
    required UserRepositoryAbstraction userRepository,
    required UserServiceAbstraction userService,
  })  : _userRepository = userRepository,
        _userService = userService,
        super(const UserProfileState(status: UserProfileStatus.initial)) {
    on<UserEnteredProfileScreenEvent>(_onScreenEnter);
    on<UserChangePasswordPressed>(_onPasswordUpdatePressed);
  }

  void _onScreenEnter(UserEnteredProfileScreenEvent event,
      Emitter<UserProfileState> emitter) async {
    var user = await _userRepository.getCurrentUser();
    if (user.isLeft) {
      emitter(const UserProfileState(status: UserProfileStatus.loadingFailure));
    }

    emitter(UserProfileState(
        status: UserProfileStatus.idle,
        user: user.isRight ? user.right : null));
  }

  void _onPasswordUpdatePressed(UserChangePasswordPressed event,
      Emitter<UserProfileState> emitter) async {
    emitter(state.copyWith(status: UserProfileStatus.passwordUpdate));
    var updateDto = PasswordUpdateRequest(
        oldPassword: event.oldPassword, newPassword: event.newPassword);
    var result = await _userService.updateUserPassword(updateDto);
    if (result.isRight) {
      emitter(state.copyWith(status: UserProfileStatus.updateSuccess));
    } else {
      emitter(state.copyWith(status: UserProfileStatus.updateFailure));
    }
    emitter(state.copyWith(status: UserProfileStatus.idle));
  }
}
