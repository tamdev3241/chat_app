import 'package:chat_app/constrain/constrain.dart';
import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/chat_screen/ui/chat_screen.dart';
import 'package:chat_app/screen/home_screen/bloc/get_list_user_bloc/get_list_user_bloc.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({Key? key}) : super(key: key);
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage>
    with AutomaticKeepAliveClientMixin {
  final GetListUserBloc getListUserBloc = GetListUserBloc();
  AuthBloc? authBloc;

  String? generateChatRoomId(String? user1, String user2) {
    if (user1!.compareTo(user2) >= 0) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    getListUserBloc.add(GetListUser());
  }

  @override
  void dispose() {
    super.dispose();
    getListUserBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return Flexible(
      child: BlocBuilder<GetListUserBloc, GetListUserState>(
        bloc: getListUserBloc,
        builder: (_, state) {
          if (state.status == ListUserStatus.success) {
            return ListView.builder(
              itemCount: state.listUser!.length,
              itemBuilder: (_, index) {
                bool isUser =
                    authBloc!.state.user!.uid == state.listUser![index]["uid"];
                final String name = state.listUser![index]['name'];
                return isUser
                    ? const SizedBox.shrink()
                    : Card(
                        child: ListTile(
                          onTap: () => Future.delayed(
                            ConstrainApp.kdefaultDuration,
                            () => Navigator.pushNamed(
                              context,
                              RouteName.chat,
                              arguments: DataChatScreen(
                                chatRoomId: generateChatRoomId(
                                  authBloc!.state.user!.displayName,
                                  state.listUser![index]['name'],
                                )!,
                                user: <String, dynamic>{
                                  "name": state.listUser![index]["name"],
                                  "email": state.listUser![index]["email"],
                                  "uid": state.listUser![index]["uid"],
                                },
                              ),
                            ),
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.5),
                            ),
                            child: Text(
                              name[0].toUpperCase(),
                              style: theme.textTheme.headline5!.copyWith(
                                color: theme.backgroundColor,
                              ),
                            ),
                          ),
                          title: Text(
                            state.listUser![index]['name'],
                            style: theme.textTheme.headline4,
                          ),
                        ),
                      );
              },
            );
          } else if (state.status == ListUserStatus.failure) {
            return Center(
              child: Text(
                "Lỗi",
                style: theme.textTheme.headline4!.copyWith(
                  color: AppColors.errorColor,
                ),
              ),
            );
          }
          return const Center(
            child: ConstrainApp.kdedaultLoadingWidget,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
