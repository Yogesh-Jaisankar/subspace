import 'package:flutter/material.dart';
import 'package:subspace/blog_modal.dart';

Widget BlogTile(Blog blog) {
  bool _loading = false;
  return Container(
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(blog.image_url), fit: BoxFit.cover)),
        ),
        SizedBox(height: 8),
        Text(
          blog.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    ),
  );
}
