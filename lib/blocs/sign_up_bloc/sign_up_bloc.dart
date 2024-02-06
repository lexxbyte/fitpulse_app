import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitpulse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;
  SignUpBloc({
    required UserRepository userRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _userRepository = userRepository,
        _authenticationBloc = authenticationBloc,
        super(const SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpProccess());
      try {
        //Pravimo novog korisnika
        MyUser user = await _userRepository.signUpWithEmailAndPassword(
            event.user, event.password);
        //Setujemo podatke korisnika u bazu podataka (Firestore)
        await _userRepository.setUserData(user);
        emit(const SignUpSuccess());
      } catch (e) {
        log(e.toString());
        emit(const SignUpFailure());
      }
    });
    //Pravimo mogucnost prijavljivanja korisnika putem Google naloga
    on<SignUpWithGoogleSignIn>((event, emit) async {
      _authenticationBloc.add(GoogleSignInRequired());
    });
  }
}
