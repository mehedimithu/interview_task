import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:task/models/blogs.dart';

class APIClient {
  var client = http.Client();
  var blogsModel = null;

  Future<BlogsModel> getBlogs() async {
    final url = Uri.https('raw.githubusercontent.com',
        'muhaiminur/muhaiminur.github.io/master/misfitflutter.tech');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        blogsModel = BlogsModel.fromJson(jsonMap);
      }
      // return blogsModel;
    } catch (Exception) {
      return blogsModel;
    }
    return blogsModel;
  }
}
