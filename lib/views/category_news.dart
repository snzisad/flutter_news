import 'package:flutter/material.dart';
import 'package:news_portal/helper/news.dart';
import 'package:news_portal/models/article_models.dart';
import 'article_view.dart';

class CategoryWiseNews extends StatefulWidget {
  final String categoryTitle;

  CategoryWiseNews({this.categoryTitle});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryWiseNews> {
  List<ArticleModel> articles = new List();
  bool isLoadingData = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async{
    var newsClass = CategoryNews();
    await newsClass.getNews(widget.categoryTitle.toString().toLowerCase());
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
            Text(widget.categoryTitle),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.save),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: isLoadingData? Center(
        child: CircularProgressIndicator()
      ):
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index){
            return  PostTile(
                title: articles[index].title,
                imgURL: articles[index].urlToImage,
                desc: articles[index].description,
                url: articles[index].url,
              );
          },
        ),
      ),
    );
  }
}


class PostTile extends StatelessWidget{
  final String imgURL, title, desc, url;
  PostTile({this.imgURL, this.title, this.desc, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(postURL: url)
        ));
      },
      child: Container(
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
      ),
    );
  }

}


