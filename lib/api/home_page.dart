import 'package:flutter/material.dart';
import 'package:newsapp/all_news.dart';
import 'package:newsapp/backend/news.dart';
import 'package:newsapp/backend/news_model.dart';
import 'package:newsapp/category_news.dart';
import 'package:newsapp/utilities/custom_gnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  

  Future<void> apifetch() async {
    NewsModel newsModel = Provider.of<NewsModel>(context, listen: false);

    newsModel.isLoading = true;

    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=9307060a4e5849a4949625362acdc8c2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> specific = responseData['articles'];

      for (var article in specific) {
        newsModel.addNewsinList(News(
            imageUrl: article['urlToImage'] ?? 'Unknown' ,
            title: article['title'] ?? 'Unknown',
            author: article['author'] ?? 'Unknown',
            description: article['description'] ?? 'Unknown',
            url: article['url'] ?? 'Unknown'));
      }
    } else {
      throw Exception('Failed to fetch Data');
    }

    newsModel.isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    apifetch();
  }

  int selectedIndex = 0;

  void bottomitemchange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const AllNews(),
    const CategoryNews(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'N E W S A P P',
          style: TextStyle(color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomGNav(
        onTabChange: (index) => bottomitemchange(index),
      ),
      body: pages[selectedIndex],
    );
  }
}
