import 'package:fitpulse_app/app_view.dart';
import 'package:fitpulse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget{
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});


  @override
  Widget build(BuildContext context){
    return  MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc(userRepository: userRepository)),
      ], 
      child: const MyAppView(),
    );
  }
}