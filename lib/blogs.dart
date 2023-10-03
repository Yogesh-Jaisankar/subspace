import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:subspace/blog_modal.dart';


class BlogService {

  Future<List<Blog>> fetchBlogs() async {
    final url = Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs');

    final headers = {
      'x-hasura-admin-secret':
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
    };

      http.Response res = await http.get(url, headers: headers);
      if (res.statusCode==200){
        Map<String,dynamic> json = jsonDecode(res.body);
        List<dynamic>body=json['blogs'];
        List<Blog> blogs = body.map((dynamic item) => Blog.fromJson(item)).toList();
        return blogs;

      }else{
        throw ('cant fetch');
      }
    }
  }

