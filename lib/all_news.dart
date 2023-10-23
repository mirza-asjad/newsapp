import 'package:flutter/material.dart';
import 'package:newsapp/backend/news.dart';
import 'package:newsapp/backend/news_model.dart';
import 'package:newsapp/design/news_design.dart';
import 'package:provider/provider.dart';

class AllNews extends StatelessWidget {
  const AllNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<NewsModel>(
      builder: (context, newsmodel, child) {
        if (newsmodel.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (newsmodel.getnewsList().isEmpty) {
          return const Center(child: Text('No News is Available'));
        } else {
          return Center(
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                itemCount: newsmodel.newslist.length, // same as getnewslist
                itemBuilder: (context, index) {
                  News news = newsmodel.newslist[index]; //understanding

                  return NewsDesign(news: news);
                },
              ))
            ]),
          );
        }
      },
    ));
  }
}
