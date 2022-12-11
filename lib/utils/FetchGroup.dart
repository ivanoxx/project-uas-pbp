import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whistleblower/models/allModel.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Forum>> fetchGroup(request) async {
  var response2 = await request.get("https://whistle-blower.up.railway.app/show-group-json/");

  var data2 = response2;
// melakukan konversi data json menjadi object ToDo
  List<Forum> listMyWatchList = [];
  for (var d in data2) {
    if (d != null) {
      listMyWatchList.add(Forum.fromJson(d));
    }
  }

  return listMyWatchList;
}
