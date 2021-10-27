import 'package:chat_app/helper/simple_bloc_delegate.dart';
import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/until/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();

  /// initial Firebase service
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// set up System UI Overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Routes routes = Routes();
  final AppTheme theme = AppTheme();
  final AuthBloc authBloc = AuthBloc();

  @override
  void dispose() {
    super.dispose();
    authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizedConfig().init(constraints, orientation);
          return GestureDetector(
            onTap: () =>
                WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus(),
            child: BlocProvider(
              create: (_) => authBloc,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: theme.lightTheme,
                initialRoute: RouteName.initial,
                onGenerateRoute: routes.routePage,
              ),
            ),
          );
        },
      ),
    );
  }
}
