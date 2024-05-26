import 'dart:convert';

ArticleModel articalModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articalModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ArticleModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    status: json["status"]??"",
    totalResults: json["totalResults"]??0,
    articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]??{}),
    author: json["author"]??"",
    title: json["title"]??"",
    description: json["description"]??"",
    url: json["url"]??"",
    urlToImage: json["urlToImage"]??"",
    publishedAt: json["publishedAt"]??"",
    content: json["content"]??"",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt,
    "content": content,
  };
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"]??"",
    name: json["name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}