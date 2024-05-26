import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/features/model/article_model.dart';
import 'package:hamzahllc/features/view_model/news_details_controller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailsScreen extends StatelessWidget with NewsDetailScreen {
  final Article article;
  const NewsDetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          article.title,
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              height: 8.0,
            ),
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
            SizedBox(
              height: 8.0,
            ),
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
              style: TextStyle(
                  color: Colors.black54, fontSize: 14
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Open Link",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              onTap: () => openUrl(article.url,context),
            )
          ],
        ),
      ),
    );
  }
}