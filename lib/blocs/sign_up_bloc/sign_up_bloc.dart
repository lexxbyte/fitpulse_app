import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
    super(const SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpProccess());
      try {
        //Pravimo novog korisnika
        MyUser user = await _userRepository.signUpWithEmailAndPassword(event.user, event.password);
        //Setujemo podatke korisnika u bazu podataka (Firestore)
        await _userRepository.setUserData(user);
        emit(const SignUpSuccess());
      } catch (e) {
        log(e.toString());
        emit(const SignUpFailure(message: 'Sign up failed'));
      }
    });
  }
}
