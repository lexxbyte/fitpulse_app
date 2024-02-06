import 'package:fitpulse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fitpulse_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:fitpulse_app/screens/home/home_screen.dart';
import 'package:fitpulse_app/screens/authentication/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FitPulse',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            background: Colors.black,
            onBackground: Colors.white,
            primary: Color.fromARGB(255, 54, 50, 52),
            onPrimary: Colors.white,
            secondary: Color.fromARGB(255, 215, 67, 57),
            onSecondary: Colors.white,
            tertiary: Color.fromARGB(255, 244, 241, 240),
            error: Color(0x00D74339),
            outline: Color(0x00D74339),
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return  BlocProvider(
                create: (context) => LogInBloc(
                  authenticationBloc: context.read<AuthenticationBloc>(),
                   userRepository: context.read<AuthenticationBloc>().userRepository,
                ),
                child: const HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          },
        ));
  }
}
