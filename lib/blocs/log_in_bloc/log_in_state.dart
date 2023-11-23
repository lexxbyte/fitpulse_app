part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();
  
  @override
  List<Object> get props => [];
}

class LogInInitial extends LogInState {}


class LogInSuccess extends LogInState{}

class LogInFailure extends LogInState{
  final String? message;

  const LogInFailure({required this.message});
}

class LogInProccess extends LogInState{}

