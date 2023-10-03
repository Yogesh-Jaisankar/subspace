import 'dart:convert';

class Blog {
  String image_url;
  String title;
  String id;

  Blog({required this.title, required this.image_url,required this.id});

  factory Blog.fromJson(Map<String,dynamic>json){
    return Blog(title: json['title'] as String, image_url: json['image_url'] as String, id: json['id']as String);
  }

}
