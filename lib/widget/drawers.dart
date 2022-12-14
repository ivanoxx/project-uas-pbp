import "package:flutter/material.dart";
import "package:whistleblower/page/all_page.dart";
import "package:whistleblower/main.dart";
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/utils/allUtils.dart';
import '../page/login.dart';
import '../page/signup.dart';
import '../models/ModelProfile.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey.shade500),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(user_data["imagePath"] as String),
                        radius: 35.0,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Flexible(
                            //   child:
                            Text(
                              user_data["alias"] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 25.0),
                            ),
                            // ),
                            const SizedBox(height: 10.0),
                            // Flexible(
                            //   child:
                            Text(
                              user_data["username"] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14.0),
                            ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Here you place your menu items
            Visibility(
              visible: request.loggedIn,
              child: ListTile(
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
            ),
            const Divider(height: 3.0),
            Visibility(
              visible: request.loggedIn,
              child: ListTile(
                leading: Icon(Icons.my_library_books),
                title: Text('My Post', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // Here you can give your route to navigate
                  if (request.loggedIn) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPostPage()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ),
            Visibility(
              visible: request.loggedIn,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out', style: TextStyle(fontSize: 18)),
                onTap: () async {
                  // Here you can give your route to navigate
                  if (!request.loggedIn) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                  const url =
                      "https://whistle-blower.up.railway.app/auth/logout/";
                  final response = await request.logout(url);
                  if (!request.loggedIn) {
                    user_data = {
                      "username": "Anonymous",
                      "alias": "Anonymous",
                      "imagePath":
                          "https://cdn.discordapp.com/attachments/902951430153981993/1048232469788377201/default.png"
                    };
                    showAlertDialog2(context);
                  } else {
                    showAlertDialog(context);
                  }
                },
              ),
            ),
            Visibility(
              visible: !request.loggedIn,
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Login', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // Here you can give your route to navigate
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),

            Visibility(
              visible: !request.loggedIn,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Sign Up', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // Here you can give your route to navigate
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
              ),
            ),
          ],
        ),
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
            onTap: () async {
              if (request.loggedIn) {
                List<Profile> lst = await fetchProfile(request);
                if (lst[0].fields.isAdmin) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HallOfShamePage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HallOfShameUserPage()));
                }
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
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
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyForumFormPage()));
              }
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
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyPostFormPage()));
              }
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

    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: FutureBuilder(
        future:
            request.get("https://whistle-blower.up.railway.app/myprofile/json"),
        builder: (context, AsyncSnapshot snapshot) => IconButton(
          iconSize: 32.0,
          icon: CircleAvatar(
            backgroundImage: !request.loggedIn
                ? NetworkImage(
                    "https://cdn.discordapp.com/attachments/902951430153981993/1048232469788377201/default.png")
                : snapshot.data != null
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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'whistleblower')));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Silahkan coba lagi!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Close"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'whistleblower',
                  )));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Anda berhasil sign out"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
