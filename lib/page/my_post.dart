import 'package:flutter/material.dart';
import 'package:whistleblower/models/ModelPost.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/main.dart';
import 'package:whistleblower/utils/allUtils.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({super.key});
  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<MyPostPageState>()
      : context.findAncestorStateOfType<MyPostPageState>();

  @override
  State<MyPostPage> createState() => MyPostPageState();
}

class MyPostPageState extends State<MyPostPage> {
  late Widget currentPage;

  void callback() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Watch List'),
          actions: const [
            profilePicture(),
          ],
        ), // Menambahkan drawer menu
        drawer: const leftDrawer(),
        endDrawer: const rightDrawer(),
        body: FutureBuilder(
            future: fetchMyPost(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Anda tidak memiliki post :(",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 2.0)
                                ],
                                border: Border.all(
                                    color:
                                    snapshot.data![index].fields.isCaptured
                                        ? Colors.white
                                        : Colors.red)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.title}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    )
                                  ]
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Written by: Anonymous ${snapshot.data![index].fields.creator}",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    )
                                  ]
                                ),
                                
                                Row(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.dateCreated}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    )
                                  ]
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.description}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    )
                                  ]
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () { },
                                      icon: Icon(
                                        Icons.arrow_circle_up_rounded,
                                        size: 22.0,
                                      ),
                                      label: Text('Upvote'),
                                    ),
                                    SizedBox(width: 7),
                                    ElevatedButton.icon(
                                      onPressed: () { },
                                      icon: Icon(
                                        Icons.add_comment_rounded,
                                        size: 22.0,
                                      ),
                                      label: Text('Reply'),
                                    ),
                                  ]
                                ),
                              ]
                            ),
                        ),

                      ));
                }
              }
            }));
  }
}