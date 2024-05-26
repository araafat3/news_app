import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamzahllc/features/model/category_models.dart';
import 'package:hamzahllc/features/screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryScreen(
              category: category.categoryName,
            )
        ));
      },
      child: Container(
          height: 70,
          width: 140,
        margin: EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black26,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    category.image
                ),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: Text(
            category.categoryName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        )
      ),
    );
  }
}