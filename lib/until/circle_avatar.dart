import 'package:chat_app/until/app_color.dart';
import 'package:flutter/material.dart';

class CircleAvatarUser extends StatefulWidget {
  final String codeName;
  final TextStyle? nameStyle;
  const CircleAvatarUser(this.codeName, {Key? key, this.nameStyle})
      : super(key: key);
  @override
  _CircleAvatarUserState createState() => _CircleAvatarUserState();
}

class _CircleAvatarUserState extends State<CircleAvatarUser> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withOpacity(0.5),
      ),
      child: Text(
        widget.codeName.toUpperCase(),
        style: widget.nameStyle ??
            theme.textTheme.headline3!.copyWith(
              color: theme.backgroundColor,
            ),
      ),
    );
  }
}
