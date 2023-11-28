part of 'authentication_bloc.dart';


//Ovu klasu koristimo za definisanje svih mogucih dogadjaja koji se desavaju unutar autentifikacije
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


class AuthenticationUserChanged extends AuthenticationEvent{
  const AuthenticationUserChanged(this.user);

  final User? user;

  @override
  List<Object> get props => [user ?? const Object()];
}
