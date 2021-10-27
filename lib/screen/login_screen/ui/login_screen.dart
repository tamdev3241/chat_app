import 'package:chat_app/constrain/constrain.dart';
import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/login_screen/bloc/login_bloc/login_bloc.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginBloc loginBloc = LoginBloc();
  AuthBloc? authBloc;
  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => loginBloc,
      child: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (_, state) {
          if (state.status == AuthStatus.success) {
            Future.delayed(
              ConstrainApp.kdefaultDuration,
              () => Navigator.pushReplacementNamed(context, RouteName.home),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.backgroundColor,
                      theme.backgroundColor,
                      const Color(0xFFE6E6E6),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const FormLoginWidget(),
                    const SizedBox(height: 10.0),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account ",
                        style: theme.textTheme.headline6,
                        children: [
                          WidgetSpan(
                            child: AppButton.text(
                              label: 'Register, now',
                              labelStyle: theme.textTheme.headline6!.copyWith(
                                color: theme.primaryColor,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Future.delayed(
                                  ConstrainApp.kdefaultDuration,
                                  () => Navigator.pushNamed(
                                    context,
                                    RouteName.signUp,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                bloc: loginBloc,
                listener: (context, state) {
                  if (state.status == LoginStatus.success) {
                    authBloc!.add(AuthenticationApp());
                  } else if (state.status == LoginStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.darkThemeColor,
                        content: Text(
                          'Login is failed',
                          style: theme.textTheme.bodyText1!.copyWith(
                            color: theme.backgroundColor,
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (_, state) {
                  if (state.status == LoginStatus.loading) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkThemeColor.withOpacity(0.4),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
