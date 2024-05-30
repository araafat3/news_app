import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/core/helper/navigation/app_navigator.dart';
import 'package:hamzahllc/core/helper/network/network_exception.dart';
import 'package:hamzahllc/core/helper/network/network_layer.dart';
import 'package:hamzahllc/core/util/constants/api_codes.dart';
import 'package:hamzahllc/features/model/article_model.dart';
import 'package:hamzahllc/features/model/category_models.dart';
import 'package:hamzahllc/features/repo/news_repository.dart';


mixin class NewsController{
  late ArticleModel news;
  late TextEditingController searchController;

  List<Article> articles=[];
  int page = 1;
  String pageSize = "20";
  bool showMore = true;

  late StreamController articleController;
  late ScrollController scrollController;

  onInit(){
    searchController=TextEditingController();
    articleController=StreamController();
    scrollController = new ScrollController()..addListener(_loadMore);
    getNews();
  }

  onDispose(){
    searchController.dispose();
    scrollController.dispose();
    articleController.close();
  }

  final List<CategoryModel> categories= const [
    CategoryModel(
        categoryName: "Business",
        image: "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80"
    ),
    CategoryModel(
        categoryName: "Entertainment",
        image:"https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
    ),
    CategoryModel(
        categoryName: "General",
        image: "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
    ),
    CategoryModel(
        categoryName: "Health",
        image:"https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80"
    ),
    CategoryModel(
        categoryName: "Science",
        image:"https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80"
    ),
    CategoryModel(
        categoryName: "Sports",
        image:"https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"
    ),
    CategoryModel(
        categoryName: "Technology",
        image:"https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
    ),
  ];

  void _loadMore() {
    if (showMore &&scrollController.position.maxScrollExtent == scrollController.offset) {
      page = page+1;
      getNews();
    }
  }

  apiSearch(){
    if(searchController.text.isEmpty || searchController.text.length >=3){
      articles.clear();
      page = 1;
      articleController.sink.add(null);
      getNews();
    }else{
      final snackBar = SnackBar(
        content: Text("You need to type three or more characters to search."),
      );
      ScaffoldMessenger.of(AppNavigator().currentContext()).showSnackBar(snackBar);
    }
  }

  getNews() async {
    try{
      final response = await NewsRepository().getNews(
          apiCode: ApiCodes.GET_NEWS_EVERYTHING,
          queryParameters: {
            "q": searchController.text.length >=3?searchController.text:"a",
            "language":"en",
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