import 'package:bloc/bloc.dart';
import 'package:fitpulse_app/app.dart';
import 'package:fitpulse_app/firebase_options.dart';
import 'package:fitpulse_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensure that all the widgets are initialized
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  ); // initialize firebase
  // Postavljamo orjentiaciju ekrana uredjaja na portrait kao predefinisano stanje
  Bloc.observer = SimpleBlocObserver(); // Ova linija koda sluzi za observaciju stanja bloc-a
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(FirebaseUserRepository()));
}