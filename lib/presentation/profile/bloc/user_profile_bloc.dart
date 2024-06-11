import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserServiceAbstraction _userService;
  final UserRepositoryAbstraction _userRepository;
  final GroupRepositoryAbstraction _groupRepository;
  UserProfileBloc(
      {required UserRepositoryAbstraction userRepository,
      required UserServiceAbstraction userService,
      required GroupRepositoryAbstraction groupRepository})
      : _userRepository = userRepository,
        _userService = userService,
        _groupRepository = groupRepository,
        super(const UserProfileState(status: UserProfileStatus.initial)) {
    on<UserEnteredProfileScreenEvent>(_onScreenEnter);
    on<UserChangePasswordPressed>(_onPasswordUpdatePressed);
  }

  void _onScreenEnter(UserEnteredProfileScreenEvent event,
      Emitter<UserProfileState> emitter) async {
    var user = await _userRepository.getCurrentUser();
    if (user == null) {
      emitter(const UserProfileState(status: UserProfileStatus.loadingFailure));
    }
    var group = await _groupRepository.getGroup();
    emitter(UserProfileState(
        status: UserProfileStatus.idle, group: group, user: user));
  }

  void _onPasswordUpdatePressed(UserChangePasswordPressed event,
      Emitter<UserProfileState> emitter) async {
    emitter(state.copyWith(status: UserProfileStatus.passwordUpdate));
    var updateDto = PasswordUpdateRequest(
        oldPassword: event.oldPassword, newPassword: event.newPassword);
    var result = await _userService.updateUserPassword(updateDto);
    if (result) {
      emitter(state.copyWith(status: UserProfileStatus.updateSuccess));
    } else {
      emitter(state.copyWith(status: UserProfileStatus.updateFailure));
    }
    emitter(state.copyWith(status: UserProfileStatus.idle));
  }
}