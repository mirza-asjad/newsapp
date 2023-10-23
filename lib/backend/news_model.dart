import 'package:flutter/foundation.dart';
import 'package:newsapp/backend/news.dart';

class NewsModel extends ChangeNotifier {
  List<News> newslist = [];

  List<News> getnewsList() {
    return newslist;
  }

  void addNewsinList(News news) {
    newslist.add(news);
    notifyListeners();
  }




// Ui updation


bool _isLoading = false;
bool get isLoading => _isLoading;

set isLoading(bool value)
{
  _isLoading = value;
  notifyListeners();
}



}
