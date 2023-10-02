import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:subspace/modals/blog_modal.dart';

class Blogs {
  List<BlogModel> blogs = [];

  void fetchBlogs() async {
    final url = Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs');

    final headers = {
      'x-hasura-admin-secret':
          '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
    };

    final response = await http.get(url, headers: headers);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      jsonData["blogs"].forEach((element) {
        if (element["image_url"] != null && element["title"] != null) {
          BlogModel blogModel = BlogModel(
              title: element['title'], imageUrl: element['image_url']);
          blogs.add(blogModel);
        }
      });
    }
  }
}
