import 'package:bloc/bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(-1);

  void onPageChange(int index) => emit(index);
}
