import 'package:flutter/material.dart';
import 'package:newsapp/backend/ctgnews_model.dart';
import 'package:newsapp/backend/news_model.dart';
import 'package:newsapp/api/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => NewsModel(),),ChangeNotifierProvider(create: (context) => CategoryNewsModel(),)],
    child:  MaterialApp(
      theme: ThemeData(primaryColor: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),);
  }
}
