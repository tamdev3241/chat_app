import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc? authBloc;
  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);

    authBloc!.add(AuthenticationApp());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondaryColor,
              AppColors.primaryColor,
              AppColors.primaryColor,
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Chat App',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: AppFontWeight.extraBold,
                  color: AppColors.lightThemeColor,
                ),
              ),
              const Spacer(),
              BlocConsumer<AuthBloc, AuthState>(
                bloc: authBloc,
                listener: (_, state) {
                  if (state.status == AuthStatus.success) {
                    Future.delayed(
                      const Duration(seconds: 1),
                      () => Navigator.pushReplacementNamed(
                          context, RouteName.home),
                    );
                  } else if (state.status == AuthStatus.failure) {
                    Future.delayed(
                      const Duration(seconds: 1),
                      () => Navigator.pushReplacementNamed(
                          context, RouteName.login),
                    );
                  }
                },
                builder: (_, state) => state.status == AuthStatus.loading
                    ? SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(
                          color: theme.backgroundColor,
                          strokeWidth: 3.0,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
