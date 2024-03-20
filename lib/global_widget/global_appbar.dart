import 'package:flutter/material.dart';
import 'package:notify/global_widget/global_textstyles.dart';

class GlAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final TextStyle? titleTextStyle;

  const GlAppbar({super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!,
         style: GLTextStyles.mainfont
      ),
      // titleTextStyle: GLTextStyles.titleStyle,
      centerTitle: centerTitle,
      // backgroundColor: ColorTheme.white,
      // surfaceTintColor: ColorTheme.white,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}