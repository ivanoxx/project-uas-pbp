import "package:flutter/material.dart";
import "package:whistleblower/page/all_page.dart";
import "package:whistleblower/main.dart";
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../page/login.dart';
import '../page/signup.dart';

class rightDrawer extends StatelessWidget {
  const rightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.cutenesscdn.com/375/media-storage/contentlab-data/10/17/199cd1d9ed9f4d45b18e5b7ce8dfe420.jpg'),
                    radius: 35.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Andi Ayuna',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'andi.ayuna@ui.ac.id',
                        style: TextStyle(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              }
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage()));
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.my_library_books),
            title: Text('My Post', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              if (request.loggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyPostPage()));
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () async {
              // Here you can give your route to navigate
              if (!request.loggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              }
              const url = "http://127.0.0.1:8000/auth/logout/";
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.person),
            title: Text('Sign Up', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupPage()));
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
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Builder(
        builder: (context) => IconButton(
          iconSize: 32.0,
          icon: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://img.cutenesscdn.com/375/media-storage/contentlab-data/10/17/199cd1d9ed9f4d45b18e5b7ce8dfe420.jpg"),
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
    );
  }
}
