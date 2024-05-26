import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/core/util/constants/app_styles.dart';
import 'package:hamzahllc/features/view_model/news_controller.dart';
import 'package:hamzahllc/features/widgets/article_widget.dart';
import 'package:hamzahllc/features/widgets/category_card.dart';


class NewsScreen extends StatefulWidget{

  NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with NewsController {

  @override
  void initState() {
    onInit();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "News",
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.symmetric(vertical: 2,horizontal: 5) ,
                          fillColor: Colors.white,
                          hintText: 'search',
                          focusedBorder:AppStyles.outlineInputBorder,
                          enabledBorder:AppStyles.outlineInputBorder,
                          border:AppStyles.outlineInputBorder,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        apiSearch(context);
                      },
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(17.0),
                          ),
                          border:Border.all(
                              color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
