import 'package:flutter/material.dart';

class PFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PFAppBar(
      {super.key,
      required this.title,
      this.automaticallyImplyLeading = true});

  final String title;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
