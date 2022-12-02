import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:whistleblower/page/all_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: const [
          profilePicture(),
        ],
      ), // Menambahkan drawer menu
      drawer: const leftDrawer(),
      endDrawer: const rightDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProfileWidget(
                      imagePath:
                          "https://img.cutenesscdn.com/375/media-storage/contentlab-data/10/17/199cd1d9ed9f4d45b18e5b7ce8dfe420.jpg",
                      onClicked: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfilePage()));
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  buildName("Andi Ayuna", "AA"),
                  const SizedBox(
                    height: 24,
                  ),
                  buildMyPostButton(),
                ],
              ),
            ),
          )
        ],
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
