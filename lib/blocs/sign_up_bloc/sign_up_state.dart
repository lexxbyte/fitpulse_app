part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpProccess extends SignUpState {
  const SignUpProccess();
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}


