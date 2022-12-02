import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whistleblower/models/ModelPost.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


Future<List<Post>> fetchTimeline(request, group_name) async {
  // TODO: Ganti ke url railway
  // var url = 'http://127.0.0.1:8000/group/$group_name/json-flutter/';
  var url = 'https://whistle-blower.up.railway.app/group/$group_name/json-flutter/';

  var response = await request.get(url);

// melakukan decode response menjadi bentuk json
//   var data = jsonDecode(utf8.decode(response.bodyBytes));

  var data = response;

// melakukan konversi data json menjadi object ToDo
  List<Post> listPost = [];
  for (var d in data) {
    if (d != null) {
      listPost.add(Post.fromJson(d));
    }
  }

  return listPost;
}
