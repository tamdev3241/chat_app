import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final Widget? titleWidget;
  final double? elevation;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Widget? leftBarButtonItem;
  final List<Widget>? rightBarButtonItems;
  final double? titleSpacing;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final PreferredSizeWidget? bottomWidget;
  final ShapeBorder? shape;
  final double? leadingWidth;
  const CommonAppBar({
    Key? key,
    this.height,
    this.titleWidget,
    this.titleSpacing = 0.0,
    this.elevation = 0.0,
    this.backgroundColor,
    this.statusBarColor,
    this.leftBarButtonItem,
    this.bottomWidget,
    this.rightBarButtonItems,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.shape,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      shape: shape,
      title: titleWidget,
      elevation: elevation,
      backgroundColor: backgroundColor ?? AppColors.lightThemeColor,
      titleSpacing: titleSpacing,
      leading: _buildLeading(),
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      centerTitle: centerTitle ?? true,
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(5, 5, 16, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: rightBarButtonItems ?? <Widget>[],
          ),
        )
      ],
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  Widget _buildLeading() {
    return (leftBarButtonItem != null)
        ? SizedBox(height: 50.0, child: leftBarButtonItem)
        : const SizedBox.shrink();
  }
}
