import 'package:flutter_bloc/flutter_bloc.dart';

///class manager bloc
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
    print('═══════════════════════════════════════════════════════════');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
    print('═══════════════════════════════════════════════════════════');
  }

  // @override
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   super.onError(cubit, error, stackTrace);
  //   print('onError $error');
  //   print('═══════════════════════════════════════════════════════════');
  // }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('onError $error');
    print('═══════════════════════════════════════════════════════════');
  }
}
