part of 'my_user_bloc.dart';

enum MyUserStatus { loading, success, failure }

class MyUserState extends Equatable {

  final MyUserStatus status;
  final MyUser? myUser;

  const MyUserState._({
    this.status = MyUserStatus.loading,
    this.myUser,
  });

  const MyUserState.loading() : this._();

  const MyUserState.success(MyUser myUser) : this._(status: MyUserStatus.success, myUser: myUser);

  const MyUserState.failure() : this._(status: MyUserStatus.failure);

    @override
  List<Object?> get props => [status, myUser];
}
