import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:chat_app/until/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemMessage extends StatefulWidget {
  final Map<String, dynamic> message;
  final Map<String, dynamic> user;
  const ItemMessage(
    this.user,
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  AuthBloc? authBloc;
  bool isSended = false;
  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    isSended = authBloc!.state.user!.uid == widget.message["sendBy"];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget message = const SizedBox.shrink();
    if (widget.message["type"] == "text") {
      message = Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        constraints: BoxConstraints.loose(
          Size.fromWidth(MediaQuery.of(context).size.width / 2.0),
        ),
        decoration: BoxDecoration(
          color: isSended
              ? AppColors.secondaryColor
              : AppColors.subLightColor.withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSended ? 15.0 : 5.0),
            topRight: const Radius.circular(15.0),
            bottomLeft: const Radius.circular(15.0),
            bottomRight: Radius.circular(isSended ? 5.0 : 15.0),
          ),
        ),
        child: Text(
          widget.message["message"],
          style: theme.textTheme.bodyText1,
          softWrap: true,
        ),
      );
    } else if (widget.message["type"] == "image") {
      message = Container(
        height: 200,
        width: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: theme.primaryColor.withOpacity(0.5),
        ),
        child: Image.network(
          widget.message["message"],
          fit: BoxFit.fill,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment:
            isSended ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isSended
              ? const SizedBox.shrink()
              : CircleAvatarUser(
                  widget.user["name"][0],
                  nameStyle: theme.textTheme.headline6!.copyWith(
                    color: theme.backgroundColor,
                  ),
                ),
          message,
        ],
      ),
    );
  }
}
