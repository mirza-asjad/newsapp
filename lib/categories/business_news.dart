import 'package:flutter/material.dart';
import 'package:newsapp/backend/ctgnews_model.dart';
import 'package:newsapp/backend/news.dart';
import 'package:newsapp/design/news_design.dart';
import 'package:provider/provider.dart';



class BusinessTab extends StatelessWidget {
  const BusinessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoryNewsModel>(builder: (context, categoryNewsModel, child) {
        if (categoryNewsModel.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (categoryNewsModel.getnewsList().isEmpty) {
          return const Center(child: Text('No News is Available'));
        }
        else
        {
          return Center(
            child: Column(
              children: [
                Expanded(child: 
                ListView.builder(
                  itemCount: categoryNewsModel.newslist.length,
                  itemBuilder: (context, index) {
                  News news = categoryNewsModel.newslist[index];
                  return NewsDesign(news: news);
                },))
              ],
            ),
          );
        }

      },)
    );
  }
}