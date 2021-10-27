import 'package:chat_app/until/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField {
  static common({
    String? hintText,
    TextStyle? hintStyle,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? errorText,
    InputBorder? boder,
    double radiusBorder = 0.0,
    Function(String input)? onChanged,
    bool isPassword = false,
    Color? backgroundColor,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBorder),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textInputAction: TextInputAction.done,
        cursorHeight: 20.0,
        cursorColor: AppColors.primaryColor,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          errorText: errorText,
          border: boder,
          filled: backgroundColor != null,
          fillColor: backgroundColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
