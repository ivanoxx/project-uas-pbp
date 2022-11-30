import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whistleblower/models/allModel.dart';

Future<List<Forum>> fetchMyWatchList() async {
  // TODO: Ganti ke url railway
  var url = Uri.parse('http://127.0.0.1:8000/show-group-json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

// melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

// melakukan konversi data json menjadi object ToDo
  List<Forum> listMyWatchList = [];
  for (var d in data) {
    if (d != null) {
      listMyWatchList.add(Forum.fromJson(d));
    }
  }

  return listMyWatchList;
}
