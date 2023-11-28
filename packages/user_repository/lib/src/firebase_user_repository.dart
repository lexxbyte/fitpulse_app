import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'entities/my_user_entity.dart';
import 'models/my_user.dart';
import 'user_repo.dart';
class FirebaseUserRepository implements UserRepository {
  //Konstruktor koji prima FirebaseAuth objekat
  //Ako FirebaseAuth nije prosledjen onda se kreira FirebaseAuth.instance
  //to oznacavaju : i ? u konstruktoru
  FirebaseUserRepository({FirebaseAuth? firebaseAuth,})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;  //_firebaseAuth je privatni atribut koji sluzi za autentifikaciju usera
  final FirebaseAuth _firebaseAuth;
  //usersCollection je privatni atribut koji sluzi za pristup kolekciji users
  final usersCollection = FirebaseFirestore.instance.collection('users');

  //Stream od [MyUser] koja emituje trenutno stanje usera kada se promeni
  //state autentifikacije
  //Emitovanje [MyUser.empty] znaci da user nije autentifikovan.
  @override
  Stream<User?> get user {
    //firebaseUser je objekat koji dobijamo od firebase i onda ga dodeljujemo
    //useru koji je tipa User? i onda ga vracamo
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  @override
  //Ako imamo Future onda moramo da imamo async
  Future<MyUser> signUpWithEmailAndPassword(
      MyUser myUser, String password) async {
    //Sve dodajemo u try blok jer se moze desiti da dodje do greske
    try {
      //Koristimo await jer je createUserWithEmailAndPassword async metoda
      //U ovoj liniji UserCredential je objekat koji dobijamo od firebase
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      //Posto nas user ima id koristimo uid da bi ga dobili
      myUser = myUser.copyWith(id: user.user!.uid);

      //Vracamo usera
      return myUser;
    } catch (e) {
      //log koristimo za logovanje greske
      log(e.toString());
      //rethrow koristimo da bi ponovo bacili gresku
      rethrow;
    }
  }

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      //Ovde smo koristili set metodu jer zelimo da kreiramo novi JSON objekat
      //koji saljemo na server
      await usersCollection.doc(myUser.id).set(myUser.toEntity().toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUserData(String id) async {
    try {
      //Ovde smo koristili get metodu jer zelimo da dobijemo JSON objekat
      //sa servera i onda koristimo fromEntity metodu da bi dobili MyUser objekat
      return usersCollection.doc(id).get().then(
          (value) => MyUser.fromEntity(MyUserEntity.fromJson(value.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
