part of 'my_user_bloc.dart';

abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent {
  final String uid;

  const GetMyUser({required this.uid});

  @override
  List<Object> get props => [uid];
}
