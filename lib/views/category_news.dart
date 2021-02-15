import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  CategoryNews({this.category});

  final String category;

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imgUrl: articles[index].urlToImage ?? "",
                            title: articles[index].title ?? "",
                            description: articles[index].description ?? "",
                            url: articles[index].url ?? "",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
