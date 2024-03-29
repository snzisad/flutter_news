import 'dart:convert';

import 'package:news_portal/helper/data.dart';
import 'package:news_portal/models/article_models.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = 'http://newsapi.org/v2/top-headlines?country=us&apiKey='+Apikey;

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
              element["author"], element["title"], element["description"], element["url"],
              element["urlToImage"], element["content"], element["publishedAt"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}


class CategoryNews{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = 'http://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey='+Apikey;

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
              element["author"], element["title"], element["description"], element["url"],
              element["urlToImage"], element["content"], element["publishedAt"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}

