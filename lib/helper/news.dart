import 'dart:convert';
import 'package:flutternews/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey={API KEY}';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['author'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            content: article['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey={API KEY}';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['author'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            content: article['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
