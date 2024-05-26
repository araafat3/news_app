import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/core/util/constants/app_styles.dart';
import 'package:hamzahllc/features/view_model/category_controller.dart';
import 'package:hamzahllc/features/view_model/news_controller.dart';
import 'package:hamzahllc/features/widgets/article_widget.dart';
import 'package:hamzahllc/features/widgets/category_card.dart';


class CategoryScreen extends StatefulWidget{
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with CategoryController {

  @override
  void initState() {
    onInit(widget.category);
    super.initState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

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
            widget.category,
            style: TextStyle(
                color: Colors.white
            ),
          ),
          centerTitle: true,
          elevation: 10,
        ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: articleController.stream,
                    builder: (BuildContext context,AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        return articles.isNotEmpty ?
                        ListView(
                            controller: scrollController,
                            children:[
                              ...articles.map(
                                      (item) => ArticleWidget(
                                      article: item
                                  )
                              ).toList(),
                              Visibility(
                                  visible: showMore,
                                  child: Center(
                                      child: CircularProgressIndicator()
                                  )
                              )
                            ]
                        ) :
                        Center(
                          child: Text(
                            'There is no news',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }else if(snapshot.hasError){
                        return Center(
                          child: Text(
                            'Error\n${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}
