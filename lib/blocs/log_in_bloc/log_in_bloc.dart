import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final UserRepository _userRepository;
  LogInBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
     super(LogInInitial()) {
    on<LogInRequired>((event, emit) async {
      emit(LogInProccess());
      try {
        await _userRepository.logInWithEmailAndPassword(event.email, event.password);
        emit(LogInSuccess());
      } catch (e) {
        log(e.toString());
        emit(const LogInFailure(message: 'Log in failed'));
      }
    });
    on<LogOutRequired>((event, emit) async {
      emit(LogInProccess());
      try {
        await _userRepository.logOut();
        emit(LogInSuccess());
      } catch (e) {
        log(e.toString());
        emit(const LogInFailure(message: 'Log out failed'));
      }
    });
  }
}
