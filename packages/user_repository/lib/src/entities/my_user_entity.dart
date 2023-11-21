import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? photoUrl;

//Konstruktor koji prima parametre i kreira MyUserEntity objekat
  const MyUserEntity({
    required this.id,
    required this.email,
    required this.username,
    this.photoUrl,
  });

//toJson metoda koja konvertuje MyUserEntity u json objekat
//koji kasnije koristimo za slanje podataka na server
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
    };
  }

  //fromJson metoda koja konvertuje json objekat u MyUserEntity objekat
  //koji kasnije koristimo za prijem podataka sa servera
  static MyUserEntity fromJson(Map<String, Object?> json) {
    return MyUserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  @override
  //ovde props koristimo za poredjenje objekata MyUserEntity
  List<Object?> get props => [id, email, username, photoUrl];

  //toString metoda koja konvertuje MyUserEntity u string
  // ''' koristimo za multi-line string
  @override
  String toString() {
    return '''MyUserEntity {
      id: $id,
     email: $email,
      username: $username,
       photoUrl: $photoUrl
       }''';
  }
}
