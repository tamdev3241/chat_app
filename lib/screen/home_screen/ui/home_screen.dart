import 'package:chat_app/constrain/constrain.dart';
import 'package:chat_app/helper/firebase_auth.dart';
import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/chat_screen/ui/chat_screen.dart';
import 'package:chat_app/screen/home_screen/bloc/get_list_user_bloc/get_list_user_bloc.dart';
import 'package:chat_app/screen/home_screen/bloc/page_cubit/page_cubit.dart';
import 'package:chat_app/screen/home_screen/ui/page/list_group.dart';
import 'package:chat_app/screen/home_screen/ui/page/list_user.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_bar.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:chat_app/until/app_icon.dart';
import 'package:chat_app/until/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final AppFireBaseAuthService auth = AppFireBaseAuthService();
  final sizeScreen = SizedConfig.heightMultiplier;
  final PageController pageController = PageController();
  AuthBloc? authBloc;
  final PageCubit pageCubit = PageCubit();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    pageCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        height: sizeScreen * 15.0,
        leadingWidth: 10.0,
        titleWidget: Text(
          "Chat App",
          style: theme.textTheme.headline2,
        ),
        rightBarButtonItems: [
          GestureDetector(
            child: Icon(
              Icons.logout,
              color: theme.iconTheme.color,
            ),
            onTap: () async {
              await auth.signOut().then(
                (value) {
                  if (value) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.login,
                      (route) => false,
                    );
                  }
                },
              );
            },
          )
        ],
        bottomWidget: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    onChanged: (String input) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        onPageChanged: (index) => pageCubit.onPageChange(index),
        controller: pageController,
        children: const [
          ListUserPage(),
          ListGroupPage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 15.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.subLightColor.withOpacity(0.5),
            ),
          ),
        ),
        child: BlocBuilder<PageCubit, int>(
          bloc: pageCubit,
          builder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: AppButton.icon(
                    icon: AppIcon.sigleChat,
                    iconColor:
                        index != 1 ? theme.primaryColor : theme.iconTheme.color,
                    onPressed: () {
                      pageCubit.onPageChange(0);
                      pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: AppButton.icon(
                    icon: AppIcon.groupChat,
                    iconColor:
                        index == 1 ? theme.primaryColor : theme.iconTheme.color,
                    onPressed: () {
                      pageCubit.onPageChange(1);
                      pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
