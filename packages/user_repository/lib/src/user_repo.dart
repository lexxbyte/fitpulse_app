import 'package:firebase_auth/firebase_auth.dart';
import 'models/models.dart';

abstract class UserRepository{

  //Kreiranje Streama usera koji ce nam sluziti za pracenje promena na useru
  //Ovaj User class je iz firebase_auth paketa i nema veze sa MyUser klasom
  //Ove dve razlicite klase koristimo kako ne bi doslo do problema sa podacima
  Stream<User?> get user;

  //LogIn metoda
  //Prima email i password kao parametre i future je zbog async operacije 
  //koja se desava u pozadini i ne zelimo da blokiramo UI
  Future<void> logInWithEmailAndPassword(String email, String password);

  //LogOut metoda 
  //Future<void> je zbog async operacije koja se desava u pozadini i ne zelimo da blokiramo UI
  Future<void> logOut();

  //SignUp metoda
  //Prima email i password kao parametre i future je zbog async operacije
  //koja se desava u pozadini i ne zelimo da blokiramo UI
  Future<MyUser> signUpWithEmailAndPassword(MyUser myUser, String password);

  //ResetPassword metoda
  //Prima email kao parametar i future je zbog async operacije
  //koja se desava u pozadini i ne zelimo da blokiramo UI
  Future<void> resetPassword(String email);

  //setUserData metoda nam sluzi kako bi mogli da postavimo podatke na server
  Future<void> setUserData(MyUser myUser);

  //getUserData metoda nam sluzi kako bi mogli da iskoristimo podatke
  //koje smo postavili na server unutar aplikacije
  Future<MyUser> getUserData(String id);
  
}