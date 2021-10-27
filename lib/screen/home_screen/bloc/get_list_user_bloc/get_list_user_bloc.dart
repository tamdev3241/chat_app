import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'get_list_user_event.dart';
part 'get_list_user_state.dart';

class GetListUserBloc extends Bloc<GetListUserEvent, GetListUserState> {
  final AppFirebaseDB firebaseDB = AppFirebaseDB();
  GetListUserBloc() : super(const GetListUserState());

  @override
  Stream<GetListUserState> mapEventToState(
    GetListUserEvent event,
  ) async* {
    if (event is GetListUser) {
      yield state.cloneWith(status: ListUserStatus.loading);
      try {
        final reslut = await firebaseDB.getAllUserFormDB();
        yield state.cloneWith(status: ListUserStatus.success, listUser: reslut);
      } catch (e) {
        yield state.cloneWith(status: ListUserStatus.failure);
      }
    }
  }
}
