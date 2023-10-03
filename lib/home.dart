import 'package:flutter/material.dart';
import 'package:subspace/blog_modal.dart';
import 'package:subspace/bloglist_tile.dart';
import 'package:subspace/blogs.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BlogService client = BlogService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("SUPSPACE"),
      ),
      body: FutureBuilder(
        future: client.fetchBlogs(),
        builder: (BuildContext context, AsyncSnapshot<List<Blog>> snapshot) {
          if (snapshot.hasData) {
            List<Blog>? blogs = snapshot.data;
            return ListView.builder(
                itemCount: blogs?.length,
                itemBuilder: (context, index) => BlogTile(blogs![index]));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
