import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_portal/helper/data.dart';
import 'package:news_portal/helper/news.dart';
import 'package:news_portal/models/article_models.dart';
import 'package:news_portal/models/category_model.dart';
import 'dart:developer' as developer;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List();
  List<ArticleModel> articles = new List();
  bool isLoadingData = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    var newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      isLoadingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: isLoadingData? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(child: Column(
            children: <Widget>[
              // categories
              Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index){
                    return  CategoryTile(
                      title: categories[index].catName,
                      imgUrl: categories[index].imgURL,
                    );
                  },
                ),
              ),

              // Posts
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index){
                    return  PostTile(
                      title: articles[index].title,
                      imgURL: articles[index].urlToImage,
                      desc: articles[index].description,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imgUrl, title;
  CategoryTile({
    this.imgUrl,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 110,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(imageUrl: imgUrl, height: 80, fit: BoxFit.cover,),
              Container(
                alignment: Alignment.center,
                color: Colors.black26,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class PostTile extends StatelessWidget{
  final String imgURL, title, desc;
  PostTile({this.imgURL, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
              child: Image.network(imgURL)
          ),
          SizedBox(height: 3,),
          Text(title, style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black87
          ),),
          SizedBox(height: 5,),
          Text(desc, style: TextStyle(
              fontSize: 13,
              color: Colors.black54
            ),
          )
        ],
      ),
    );
  }

}

