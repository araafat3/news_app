import 'package:flutter/material.dart';
import 'package:hamzahllc/features/model/article_model.dart';
import 'package:hamzahllc/features/screens/news_details_screen.dart';
import 'package:intl/intl.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  const ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              article: article,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Hero(
                tag: article.description,
                child: Image.network(
                        article.urlToImage.isNotEmpty
                            ? article.urlToImage
                            :'https://source.unsplash.com/weekly?coding',
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    article.source.name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    DateFormat("dd/ MM/ yyyy hh:mm")
                        .format(DateTime.parse(article.publishedAt).toLocal()),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              article.title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              article.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14
              ),
            )
          ],
        ),
      ),
    );
  }
}
