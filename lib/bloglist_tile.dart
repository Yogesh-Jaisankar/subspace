import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:subspace/blog_modal.dart';
import 'package:subspace/read_blog.dart';

Widget BlogTile(Blog blog, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ReadBlog(blog: blog)));
    },
    child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Placeholder color
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(blog.image_url), fit: BoxFit.cover)),
            ),
          ]),
          SizedBox(height: 8),
          Text(
            blog.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    ),
  );
}
