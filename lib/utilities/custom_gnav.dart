import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class CustomGNav extends StatelessWidget {
  void Function(int)? onTabChange;
  CustomGNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.black,
        backgroundColor: Colors.transparent,
        color: Colors.grey,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [GButton(icon: Icons.tv), GButton(icon: Icons.newspaper)],
      ),
    );
  }
}
