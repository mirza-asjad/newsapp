import 'package:flutter/material.dart';
import 'package:newsapp/backend/ctgnews_model.dart';
import 'package:newsapp/categories/business_news.dart';
import 'package:newsapp/categories/entertainment_news.dart';
import 'package:newsapp/categories/sports_news.dart';
import 'package:newsapp/categories/technology_news.dart';
import 'package:newsapp/utilities/custom_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'backend/news.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  final List<String> categories = [
    'entertainment',
    'sport',
    'technology',
    'business'
  ];
  String selectedcategory = 'entertainment';

  Future<void> apictgfetch(String category) async {
    CategoryNewsModel categoryNewsModel =
        Provider.of<CategoryNewsModel>(context, listen: false);

    categoryNewsModel.isLoading = true;

    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9307060a4e5849a4949625362acdc8c2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> specific = responseData['articles'];

      categoryNewsModel.clearnewsList(); //important line

      for (var article in specific) {
        categoryNewsModel.addNewsinList(News(
            imageUrl: article['urlToImage'] ?? 'Unknown',
            title: article['title'] ?? 'Unknown',
            author: article['author'] ?? 'Unknown',
            description: article['description'] ?? 'Unknown',
            url: article['url'] ?? 'Unknown'));
      }
    } else {
      throw Exception('Failed to fetch Data');
    }

    categoryNewsModel.isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    apictgfetch(selectedcategory);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mytabs = [
      const MyTabs(tabname: 'Entertainment'),
      const MyTabs(tabname: 'Sports'),
      const MyTabs(tabname: 'Technology'),
      const MyTabs(tabname: 'Business'),
    ];

    return DefaultTabController(
      length: mytabs.length,
      child: Scaffold(
          body: Column(
        children: [
          TabBar(
            tabs: mytabs,
            isScrollable: true,
            onTap: (index) {
              setState(() {
                selectedcategory = categories[index];
              });
              apictgfetch(selectedcategory);              
            } ,
          ),
          const Expanded(
              child: TabBarView(children: [
            EntertainmentTab(),
            SportsTab(),
            TechnologyTab(),
            BusinessTab(),
          ],
          ),
          )
        ],
        
      ),
      ),
      
    );
  }
}
