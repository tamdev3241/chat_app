part of 'get_list_user_bloc.dart';

enum ListUserStatus { initial, loading, success, failure }

class GetListUserState extends Equatable {
  final ListUserStatus status;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? listUser;
  const GetListUserState({
    this.status = ListUserStatus.initial,
    this.listUser,
  });

  GetListUserState cloneWith({
    ListUserStatus? status,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? listUser,
  }) =>
      GetListUserState(
        status: status ?? this.status,
        listUser: listUser ?? this.listUser,
      );
  @override
  List<Object> get props => [status];
}
