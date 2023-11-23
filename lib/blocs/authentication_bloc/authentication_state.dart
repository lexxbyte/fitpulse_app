part of 'authentication_bloc.dart';

//Definisemo enum sa tri moguca stanja autentifikacije
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable{

  final AuthenticationStatus status;
  final User? user;


  //Definisemo konstruktor koji ce da vraca objekat AuthenticationState i unutar njega imamo parametre status i user
  //Ovaj konstruktor je private i moze da se koristi samo unutar ove klase i obelezavamo ga sa _(underscore) ispred imena
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  //Ovaj konstruktor koristimo za unknown stanje i on vraca prazan konstruktor
  //Nema informacija o korisniku i statusu
  const AuthenticationState.unknown() 
  : this._();

  //Trenutni korisnik je autentifikovan i prosledjujemo mu user i status
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  //Trenutni korisnik nije autentifikovan i prosledjujemo mu status
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);



  @override
  List<Object?> get props => [status, user];

}
