import 'package:chat_app/constrain/constrain.dart';
import 'package:chat_app/routes/route_name.dart';
import 'package:chat_app/screen/sign_up_screen/bloc/bloc/signup_bloc.dart';
import 'package:chat_app/screen/sign_up_screen/ui/form_signup_widget.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpBloc signUpBloc = SignUpBloc();

  @override
  void dispose() {
    super.dispose();
    signUpBloc.close();
  }

  void popScreen() {
    FocusScope.of(context).unfocus();
    Future.delayed(
      ConstrainApp.kdefaultDuration,
      () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (_) => signUpBloc,
        child: Stack(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton.icon(
                      icon: CupertinoIcons.back,
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 10.0,
                      ),
                      onPressed: () => popScreen(),
                    ),
                  ),
                  const Spacer(),
                  const FormSignupWidget(),
                  const SizedBox(height: 10.0),
                  RichText(
                    text: TextSpan(
                      text: "I have an account ",
                      style: theme.textTheme.headline6,
                      children: [
                        WidgetSpan(
                          child: AppButton.text(
                            label: 'Login',
                            labelStyle: theme.textTheme.headline6!.copyWith(
                              color: theme.primaryColor,
                            ),
                            onPressed: () => popScreen(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            BlocConsumer<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              listener: (context, state) {
                if (state.status == SignUpStatus.success) {
                  Future.delayed(
                    ConstrainApp.kdefaultDuration,
                    () => Navigator.pushReplacementNamed(
                        context, RouteName.login),
                  );
                } else if (state.status == SignUpStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.darkThemeColor,
                      content: Text(
                        'SignUp is failed',
                        style: theme.textTheme.bodyText1!.copyWith(
                          color: theme.backgroundColor,
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (_, state) {
                if (state.status == SignUpStatus.loading) {
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
    );
  }
}
