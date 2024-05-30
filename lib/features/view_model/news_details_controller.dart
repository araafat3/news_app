import 'package:flutter/material.dart';
import 'package:hamzahllc/core/helper/navigation/app_navigator.dart';
import 'package:url_launcher/url_launcher_string.dart';

mixin class NewsDetailScreen{

  openUrl(String url,BuildContext context) async {
    try{
      await launchUrlString(url,mode: LaunchMode.inAppWebView,);
    }catch(error){
      final snackBar = SnackBar(
        content: Text('Could not launch $url'),
      );
      ScaffoldMessenger.of(AppNavigator().currentContext()).showSnackBar(snackBar);
      throw 'Could not launch $url';
    }
  }

}