import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_auth_bloc_event.dart';
part 'google_auth_bloc_state.dart';

class GoogleAuthBlocBloc extends Bloc<GoogleAuthBlocEvent, GoogleAuthBlocState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleAuthBlocBloc() : super(GoogleAuthInitial()) {
    on<GoogleAuthBlocEvent>((event, emit) async {
      emit(GoogleAuthLoading());
      try {
        final userAccount = await _googleSignIn.signIn();

        if (userAccount == null) {
          emit(const GoogleAuthFailure(message: 'Google sign in aborted'));
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await userAccount.authentication;


            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            final userCredential =
                await _firebaseAuth.signInWithCredential(credential);

                emit(GoogleAuthSuccess(user: userCredential.user));
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }
}
