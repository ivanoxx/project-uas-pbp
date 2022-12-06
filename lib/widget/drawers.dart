import "package:flutter/material.dart";
import "package:whistleblower/page/all_page.dart";
import "package:whistleblower/main.dart";
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/utils/allUtils.dart';
import '../page/login.dart';
import '../page/signup.dart';

class rightDrawer extends StatelessWidget {
  const rightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    if (request.loggedIn) {
      fetchUserData(request);
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(user_data["imagePath"] as String),
                    radius: 35.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user_data["alias"] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        user_data["username"] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          //Here you place your menu items
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              if (!request.loggedIn) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.my_library_books),
            title: Text('My Post', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              if (request.loggedIn) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPostPage()));
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () async {
              // Here you can give your route to navigate
              if (!request.loggedIn) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
              const url = "https://whistle-blower.up.railway.app/auth/logout/";
              //const url = "https://whistle-blower.up.railway.app/auth/logout/";
              final response = await request.logout(url);
            },
          ),
        ],
      ),
    );
  }
}

class leftDrawer extends StatelessWidget {
  const leftDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          const SafeArea(
            // padding:
            //     EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
            // TODO: Tambahin tombol buat close
            child: Padding(
              padding: EdgeInsets.all(8.0),
              // Nanti kasih logo
              child: Text(
                'Whistleblower',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.home),
            title: Text('Homepage', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: "Whistleblower")));
            },
          ),
          ListTile(
            trailing: Icon(Icons.account_balance),
            title: Text('Hall of Shame', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HallOfShamePage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.group_add),
            title: Text('Create Forum', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              if (!request.loggedIn) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyForumFormPage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.create),
            title: Text('Create Post', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              if (!request.loggedIn) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyPostFormPage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.account_circle),
            title: Text('Login', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.person),
            title: Text('Sign Up', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
          ),
        ],
      ),
    );
  }
}

class profilePicture extends StatelessWidget {
  const profilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    fetchUserData(request);
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: FutureBuilder(
        future:
            request.get("https://whistle-blower.up.railway.app/myprofile/json"),
        builder: (context, AsyncSnapshot snapshot) => IconButton(
          iconSize: 32.0,
          icon: CircleAvatar(
            backgroundImage: snapshot.data != null
                ? NetworkImage(
                    "https://whistle-blower.up.railway.app/images/${snapshot.data[0]['fields']['image']}")
                : NetworkImage(user_data["imagePath"] as String),
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
    );
  }
}
