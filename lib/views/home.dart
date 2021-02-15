import 'package:flutter/material.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/helper/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = new List<CategoryModel>();

  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News news = News();
    await news.getNews();
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
                    /// Categories
                    Container(
                      height: 70,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageURL: categories[index].imageURL,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),

                    /// Blogs
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
