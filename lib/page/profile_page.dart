import 'package:flutter/material.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String alias = "";
String imagePath = "";

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: const [
          profilePicture(),
        ],
      ), // Menambahkan drawer menu
      drawer: const leftDrawer(),
      endDrawer: const rightDrawer(),
      body: FutureBuilder(
        future: request.get("https://whistle-blower.up.railway.app/myprofile/json"),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            alias = snapshot.data![0]['fields']['alias'];
            imagePath =
                "https://whistle-blower.up.railway.app/images/${snapshot.data![0]['fields']['image']}";
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ProfileWidget(
                            imagePath: imagePath,
                            onClicked: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage()));
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        buildName(alias, username),
                        const SizedBox(
                          height: 24,
                        ),
                        buildMyPostButton(),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildName(String username, String alias) => Column(
        children: [
          Text(
            username,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            alias,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildMyPostButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
        child: Text('My Post'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyPostPage()));
        },
      );
}
