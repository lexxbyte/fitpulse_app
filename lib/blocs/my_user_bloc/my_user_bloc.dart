import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;
  MyUserBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
   super(MyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      //Posto je po defaultu da se emituje loading stanje, ne moramo da ga pisemo dok se vrsi provera 
      //da li je success ili failure
      try {
        //Ovde pozivamo funkciju iz user_repository koja vraca myUser id
        final myUser = await _userRepository.getUserData(event.uid);
        //Probamo success i ako je success onda emitujemo success stanje
        emit(MyUserState.success(myUser));
      } catch (e) {
        log(e.toString());
        emit(const MyUserState.failure());
      }
    });
  }
}
