import 'package:flutter/material.dart';

class AppButton {
  static Widget common({
    required String? label,
    required Function()? onPressed,
    TextStyle? labelStyle,
    Color? backgroundColor,
  }) {
    return RawMaterialButton(
      fillColor: backgroundColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(label ?? 'label button', style: labelStyle),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      onPressed: onPressed,
    );
  }

  static Widget text({
    required String label,
    required Function()? onPressed,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? padding,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: Text(label, style: labelStyle),
      ),
    );
  }

  static Widget icon({
    required IconData icon,
    required Function()? onPressed,
    Color? iconColor,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          icon,
          size: iconSize ?? 30.0,
          color: iconColor,
        ),
      ),
    );
  }
}
