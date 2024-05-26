import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/core/helper/network/network_exception.dart';
import 'package:hamzahllc/core/helper/network/network_layer.dart';
import 'package:hamzahllc/core/util/constants/api_codes.dart';
import 'package:hamzahllc/features/model/article_model.dart';
import 'package:hamzahllc/features/model/category_models.dart';
import 'package:hamzahllc/features/repo/news_repository.dart';


mixin class CategoryController{
  late ArticleModel news;

  List<Article> articles=[];
  int page = 1;
  String pageSize = "20";
  bool showMore = true;
  late String _category;

  late StreamController articleController;
  late ScrollController scrollController;

  onInit(String category){
    articleController=StreamController();
    scrollController = new ScrollController()..addListener(_loadMore);
    _category=category;
    getNews();
  }

  onDispose(){
    scrollController.dispose();
    articleController.close();
  }

  void _loadMore() {
    if (showMore &&scrollController.position.maxScrollExtent == scrollController.offset) {
      page = page+1;
      getNews();
    }
  }

  getNews() async {
    try{
      final response = await NewsRepository().getNews(
          apiCode: ApiCodes.GET_NEWS_CATEGORY,
          queryParameters: {
            "language":"en",
            "category":_category.toLowerCase(),
            "sortBy":"publishedAt",
            "page": page.toString(),
            "pageSize": pageSize
          }
      );
      news=articalModelFromJson(jsonEncode(response));
      articles.addAll(news.articles);
      showMore=articles.length<news.totalResults;
      articleController.sink.add(articles);
    }on DioExceptionHandler catch(error){
      rethrow;
    }

  }

}