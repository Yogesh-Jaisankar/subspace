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

  List<Category> categories = [
    Category("Business",
        "https://images.pexels.com/photos/1957478/pexels-photo-1957478.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
    Category("Entertainment",
        "https://images.pexels.com/photos/987586/pexels-photo-987586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
    Category("Motivation",
        "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "S U B ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat")),
          TextSpan(
              text: "S P A C E",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"))
        ])),
      ),
      body: FutureBuilder(
        future: client.fetchBlogs(),
        builder: (BuildContext context, AsyncSnapshot<List<Blog>> snapshot) {
          if (snapshot.hasData) {
            List<Blog>? blogs = snapshot.data;
            return Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        categories[index].imageUrl),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10)),
                            width: 130,
                          ),
                          Center(
                            child: Text(
                              categories[index].title,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: blogs?.length,
                      itemBuilder: (context, index) =>
                          BlogTile(blogs![index], context)),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String title;
  final String imageUrl;

  Category(this.title, this.imageUrl);
}
