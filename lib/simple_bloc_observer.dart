//Ovaj fajl koristimo za bacanje log-a koju nam bloc vraca
import 'dart:developer';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver{
  //Sada ovde implementujemo neke metode koje nam bloc observer nudi
  //onCreate metoda se poziva kada se bloc kreira
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  //onEvent metoda se poziva kada se event emituje
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  //onChange metoda se poziva kada se stanje bloc-a promeni
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  //onError metoda se poziva kada se dogodi greska
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError -- bloc: ${bloc.runtimeType}, error: $error');
  }

  //onClose metoda se poziva kada se bloc zatvori
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: ${bloc.runtimeType}');
  }
}