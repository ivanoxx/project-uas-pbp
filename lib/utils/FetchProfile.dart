import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whistleblower/models/ModelProfile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


Future<List<Profile>> fetchProfile(request) async {

        final response = await request.get("https://whistle-blower.up.railway.app/myprofile/json");

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object ToDo
        List<Profile> listToDo = [];
        for (var d in data) {
        if (d != null) {
            listToDo.add(Profile.fromJson(d));
        }
        }

        return listToDo;
    }