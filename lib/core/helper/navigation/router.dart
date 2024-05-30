import 'dart:developer';

import 'package:hamzahllc/core/util/constants/route_name.dart';
import 'package:hamzahllc/features/model/article_model.dart';
import 'package:hamzahllc/features/screens/category_screen.dart';
import 'package:hamzahllc/features/screens/news_details_screen.dart';
import 'package:flutter/material.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  log("Route Name:" + settings.name.toString());
  log("Route arg:" + settings.arguments.toString());

  switch (settings.name) {
    case RoutesNames.NEWS_CATEGORY_ROUTE :
      return MaterialPageRoute(builder: (context)=>
          CategoryScreen(category: settings.arguments as String)
      );

      case RoutesNames.NEWS_DETAILS_ROUTE :
      return MaterialPageRoute(builder: (context)=>
          NewsDetailsScreen(article: settings.arguments as Article)
      );


    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("no path for ${settings.name}"),
            ),
          )
      );

  }
}
