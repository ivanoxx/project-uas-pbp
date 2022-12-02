import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whistleblower/models/allModel.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Forum>> fetchGroup(request) async {
  // TODO: Ganti ke url railway
  var url = Uri.parse('https://whistle-blower.up.railway.app/show-group-json/');
  var response = await request.get(url);

// melakukan decode response menjadi bentuk json
  var data = response;

// melakukan konversi data json menjadi object ToDo
  List<Forum> listMyWatchList = [];
  for (var d in data) {
    if (d != null) {
      listMyWatchList.add(Forum.fromJson(d));
    }
  }

  return listMyWatchList;
}
