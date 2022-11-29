import "package:flutter/material.dart";
import "package:whistleblower/page/all_page.dart";
import "package:whistleblower/main.dart";

class rightDrawer extends StatelessWidget {
  const rightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey.shade500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.cutenesscdn.com/375/media-storage/contentlab-data/10/17/199cd1d9ed9f4d45b18e5b7ce8dfe420.jpg'),
                  radius: 40.0,
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

          //Here you place your menu items
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.my_library_books),
            title: Text('My Post', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
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
    return Drawer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: Tambahin tombol buat close
            child: Text(
              'Whistleblower',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
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
                      builder: (context) => const MyHomePage(title: "Whistleblower")));
            },
          ),
          ListTile(
            trailing: Icon(Icons.account_balance),
            title: Text('Hall of Shame', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: Icon(Icons.group_add),
            title: Text('Create Forum', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyPostFormPage()));
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