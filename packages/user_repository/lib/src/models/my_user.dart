import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? photoUrl;

//Konstruktor koji prima parametre i kreira MyUser objekat
  const MyUser({
    required this.id,
    required this.email,
    required this.username,
    this.photoUrl,
  });

//Kreiramo praznog usera koji je prezentacija usera koji nije autentificiran
  static const empty = MyUser(
    id: '', 
    email: '', 
    username: '', 
    photoUrl: ''
    );

//CopyWith metodu koristimo za update usera jer je user immutable objekt
    MyUser copyWith({
    String? id,
    String? email,
    String? username,
    String? photoUrl,
  }) {
    //Vracamo objekat MyUser koji je kopija trenutnog objekta sa novim vrednostima
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  //Getter da li je user prazan ili nije
  bool get isEmpty => this == MyUser.empty;

  //Getter koji odredjuje da li je user popunjen ili nije
  bool get isNotEmpty => this != MyUser.empty;

  //Metoda koja extenduje MyUserEntity klasu
  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      username: username,
      photoUrl: photoUrl,
    );
  }

  //Metoda koja konvertuje MyUserEntity u MyUser
  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      photoUrl: entity.photoUrl,
    );
  }

//props koristimo za poredjenje objekata izmedju sebe u ovom slucaju MyUser objekata
  @override
  List<Object?> get props => [id, email, username, photoUrl];
}
