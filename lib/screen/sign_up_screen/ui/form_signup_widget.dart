import 'package:chat_app/helper/firebase_auth.dart';
import 'package:chat_app/screen/login_screen/bloc/validate_form_bloc/validate_form_bloc.dart';
import 'package:chat_app/screen/sign_up_screen/bloc/bloc/signup_bloc.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:chat_app/until/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSignupWidget extends StatefulWidget {
  const FormSignupWidget({Key? key}) : super(key: key);

  @override
  _FormSignupWidgetState createState() => _FormSignupWidgetState();
}

class _FormSignupWidgetState extends State<FormSignupWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _focusemailNode = FocusNode();
  final FocusNode _focusPassNode = FocusNode();
  final AppFireBaseAuthService auth = AppFireBaseAuthService();
  final FormValidatorBloc formValidatorBloc = FormValidatorBloc();
  SignUpBloc? signUpBloc;

  String? errorEmailText;
  String? errorPasswordText;
  @override
  void initState() {
    super.initState();
    signUpBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    formValidatorBloc.close();
    _focusemailNode.dispose();
    _focusPassNode.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Sign Up', style: theme.textTheme.headline3),
          ),
          const SizedBox(height: 20.0),
          BlocBuilder<FormValidatorBloc, FormValidatorState>(
            bloc: formValidatorBloc,
            builder: (context, state) {
              errorEmailText = state.emailErrorText;
              errorPasswordText = state.passErrorText;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField.common(
                    focusNode: _focusemailNode,
                    controller: _emailController,
                    hintText: 'Email',
                    errorText: errorEmailText,
                    hintStyle: theme.textTheme.bodyText2,
                    boder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subLightColor,
                        width: 0.5,
                      ),
                    ),
                    onChanged: (String input) => formValidatorBloc.add(
                      CheckFormEvent(input, _passController.text),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  AppTextField.common(
                    focusNode: _focusPassNode,
                    controller: _passController,
                    errorText: errorPasswordText,
                    hintText: 'Password',
                    hintStyle: theme.textTheme.bodyText2,
                    isPassword: true,
                    boder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subLightColor,
                        width: 0.5,
                      ),
                    ),
                    onChanged: (String input) => formValidatorBloc.add(
                      CheckFormEvent(_emailController.text, input),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: AppButton.common(
                  backgroundColor: AppColors.primaryColor,
                  label: 'SignUp',
                  labelStyle: theme.textTheme.headline6!.copyWith(
                    color: theme.backgroundColor,
                  ),
                  onPressed: () async {
                    if (formValidatorBloc.state.status ==
                        FormValidStatus.success) {
                      FocusScope.of(context).unfocus();
                      signUpBloc!.add(
                        SignUpUserEvent(
                          _emailController.text,
                          _passController.text,
                        ),
                      );
                    } else {
                      formValidatorBloc.add(
                        CheckFormEvent(
                          _emailController.text,
                          _passController.text,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 60.0),
        ],
      ),
    );
  }
}
