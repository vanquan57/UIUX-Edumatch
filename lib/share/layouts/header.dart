import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(185);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Header'),  
      centerTitle: true,
    );
  }
}
