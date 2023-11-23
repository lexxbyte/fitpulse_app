import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

//U ovom fajlu ce nam takodje trebati ceo repository usera i stream subscription

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //Deklaracija User repository-ja i stream subscription-a
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;
  //U ovom konstruktoru ubacujemo inicijalnu vrednost koja je unknown jer kada korisnik
  //prvi put pristupi aplikaciji ne znamo da li je autentifikovan ili ne
  AuthenticationBloc({
    //Ovde ubacujemo required parametar koji je userRepository i on nasledjuje userRepository
    required this.userRepository,
  })  : super(const AuthenticationState.unknown()) {
    //Ovde implementujemo stream subscription i on slusa usera i kada se user promeni
    _userSubscription = userRepository.user.listen(
      //add metoda dodaje novi event u stream i koristimo AuthenticationUserChanged metodu koju smo definisali
      //u authentication_event.dart
      (authUser) => add(AuthenticationUserChanged(authUser)),
    );


    //Ovde koristimo on AuthenticationUserChanged metodu koju smo definisali u authentication_event.dart
    //proveravamo da li je user null ili nije i ako nije onda emitujemo stanje authenticated
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  //Dodamo close metodu koja ce da zatvori stream subscription
  //Zatvaranje je obavezno zbog memory leak-a
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
