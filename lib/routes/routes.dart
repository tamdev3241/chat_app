import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/chat_screen/ui/chat_screen.dart';
import 'package:chat_app/screen/home_screen/ui/home_screen.dart';
import 'package:chat_app/screen/login_screen/ui/login_screen.dart';
import 'package:chat_app/screen/sign_up_screen/ui/signup_screen.dart';
import 'package:chat_app/screen/splash_screen.dart/ui/splash_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class RouteInterFace {
  CupertinoPageRoute routePage(RouteSettings settings);
}

class Routes implements RouteInterFace {
  @override
  CupertinoPageRoute routePage(RouteSettings settings) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {

          /// -------------- Chat Screen -------------------
          case RouteName.chat:
            return ChatScreen(
              data: settings.arguments as DataChatScreen,
            );

          /// -------------- Home Screen -------------------
          case RouteName.home:
            return const HomeScreen();

          /// -------------- Login Screen ------------------
          case RouteName.login:
            return const LoginScreen();

          /// -------------- Login Screen ------------------
          case RouteName.signUp:
            return const SignUpScreen();

          /// ------ Default navigate Splash screen ---------
          default:
            return const SplashScreen();
        }
      },
    );
  }
}
