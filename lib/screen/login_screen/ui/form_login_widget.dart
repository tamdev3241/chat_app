import 'package:chat_app/helper/firebase_auth.dart';
import 'package:chat_app/screen/login_screen/bloc/login_bloc/login_bloc.dart';
import 'package:chat_app/screen/login_screen/bloc/validate_form_bloc/validate_form_bloc.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:chat_app/until/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({Key? key}) : super(key: key);

  @override
  _FormLoginWidgetState createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _focusemailNode = FocusNode();
  final FocusNode _focusPassNode = FocusNode();
  final FormValidatorBloc validFormBloc = FormValidatorBloc();
  final AppFireBaseAuthService auth = AppFireBaseAuthService();
  late LoginBloc loginBloc;
  String? errorTextEmail;
  String? errorTextPass;
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    validFormBloc.close();
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
            child: Text('Login', style: theme.textTheme.headline3),
          ),
          const SizedBox(height: 20.0),
          BlocBuilder<FormValidatorBloc, FormValidatorState>(
            bloc: validFormBloc,
            builder: (context, state) {
              errorTextEmail = state.emailErrorText;
              errorTextPass = state.passErrorText;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField.common(
                    focusNode: _focusemailNode,
                    controller: _emailController,
                    hintText: 'Email',
                    hintStyle: theme.textTheme.bodyText2,
                    boder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subLightColor,
                        width: 0.5,
                      ),
                    ),
                    errorText: errorTextEmail,
                    onChanged: (String input) {
                      validFormBloc.add(
                        CheckFormEvent(input, _passController.text),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  AppTextField.common(
                    focusNode: _focusPassNode,
                    controller: _passController,
                    hintText: 'Password',
                    hintStyle: theme.textTheme.bodyText2,
                    isPassword: true,
                    boder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subLightColor,
                        width: 0.5,
                      ),
                    ),
                    errorText: errorTextPass,
                    onChanged: (String input) {
                      validFormBloc.add(
                        CheckFormEvent(_emailController.text, input),
                      );
                    },
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
                  label: 'Login',
                  labelStyle: theme.textTheme.headline6!.copyWith(
                    color: theme.backgroundColor,
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (validFormBloc.state.status == FormValidStatus.success) {
                      loginBloc.add(
                        LoginUserEvent(
                          _emailController.text,
                          _passController.text,
                        ),
                      );
                    } else {
                      validFormBloc.add(
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
