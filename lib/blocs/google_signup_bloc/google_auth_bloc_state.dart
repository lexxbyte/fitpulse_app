part of 'google_auth_bloc_bloc.dart';

abstract class GoogleAuthBlocState extends Equatable {
  const GoogleAuthBlocState();
  
  @override
  List<Object> get props => [];
}

class GoogleAuthInitial extends GoogleAuthBlocState {}

class GoogleAuthSuccess extends GoogleAuthBlocState{
  final User? user;

  const GoogleAuthSuccess({required this.user});
}

class GoogleAuthLoading extends GoogleAuthBlocState{}

class GoogleAuthFailure extends GoogleAuthBlocState{
  final String? message;

  const GoogleAuthFailure({required this.message});
}


