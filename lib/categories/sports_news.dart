import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/ctgnews_model.dart';
import '../backend/news.dart';
import '../design/news_design.dart';



class SportsTab extends StatelessWidget {
  const SportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoryNewsModel>(builder: (context, categoryNewsModel, child)
      {
        if(categoryNewsModel.isLoading)
        {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black,),
          );
        }
        else if(categoryNewsModel.getnewsList().isEmpty)
        {
          return const Center(
            child: Text('No News is Available'),
          );

        }
        else
        {
          return Center(
            child: Column(children: [
              Expanded(child: 
              ListView.builder(
                itemCount: categoryNewsModel.newslist.length,itemBuilder: (context, index) {
                News news = categoryNewsModel.newslist[index];
                return NewsDesign(news: news);
              },))
            ]),
          );
        }

      },)
        
      
    );
  }
}