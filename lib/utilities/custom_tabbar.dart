import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  final String tabname;
  const MyTabs({super.key, required this.tabname});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 70,      
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey),
        padding: const EdgeInsets.all(20),        
        child: Text(
          tabname,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
