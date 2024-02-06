import 'package:fitpulse_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<LogInBloc>().add(const LogOutRequired());
            },
            icon:  Icon(CupertinoIcons.square_arrow_right,
            color: Theme.of(context).colorScheme.onSecondary,),
          ),
        ],
      ),
      );
  }
}