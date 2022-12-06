import 'package:whistleblower/models/ModelProfile.dart';
import 'package:whistleblower/page/all_page.dart';
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


Future<List<Profile>> fetchUserData(CookieRequest request) async {
  final response = await fetchProfile(request);

  user_data = {
    "username": username,
    "alias": response[0].fields.alias,
    "imagePath":
    "https://whistle-blower.up.railway.app/images/${response[0].fields.image}"
  };

  return response;
}
