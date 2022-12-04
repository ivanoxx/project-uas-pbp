import 'dart:convert';
import 'package:whistleblower/models/ModelProfile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Profile>> fetchProfile(request) async {
  final response =
      await request.get("https://whistle-blower.up.railway.app/myprofile/json");

  // melakukan konversi data json menjadi object Profile
  List<Profile> listProfile = [];
  for (var d in response) {
    if (d != null) {
      listProfile.add(Profile.fromJson(d));
    }
  }

  return listProfile;
}
