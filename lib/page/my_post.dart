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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Post'),
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
                if (snapshot.data!.length == 0) {
                  return Column(
                    children: const [
                      Flexible(
                        child: Text(
                          "Anda tidak memiliki post :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 2.0)
                          ],
                          border: Border.all(
                              color: snapshot.data![index].fields.isCaptured
                                  ? Colors.red
                                  : Colors.white)),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: Text(
                              "${snapshot.data![index].fields.title}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CustomButtonTest(
                              post: snapshot.data![index],
                              callbackFunction: callback),
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          Flexible(
                            child: Text(
                              "Written by: Anonymous ${snapshot.data![index].fields.creator}",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          )
                        ]),
                        Row(children: [
                          Flexible(
                            child: Text(
                              "Created: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(snapshot.data![index].fields.dateCreated.toString()))}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        ]),
                        Row(children: [
                          Flexible(
                            child: Text(
                              "${snapshot.data![index].fields.description}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        ]),
                        Visibility(
                          visible: snapshot.data![index].fields.isCaptured,
                          child: Row(children: [
                            Flexible(
                              child: Text(
                                "Arrested date : ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(snapshot.data![index].fields.dateCaptured == null ? DateTime.now().toString() : snapshot.data![index].fields.dateCaptured.toString()))}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                          Flexible(child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return ElevatedButton.icon(
                                onPressed: () async {
                                  if (request.loggedIn) {
                                    final url =
                                        "https://whistle-blower.up.railway.app/mypost/${snapshot.data![index].pk}/upvote/";
                                    final response = await request.get(url);
                                    setState(() {
                                      snapshot.data![index].fields.upvoteCount =
                                          response['upvote'];
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  size: 22.0,
                                ),
                                label: Text(snapshot
                                    .data![index].fields.upvoteCount
                                    .toString()),
                              );
                            },
                          )),
                          SizedBox(width: 7),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                          post: snapshot.data![index])));
                            },
                            icon: Icon(
                              Icons.add_comment_rounded,
                              size: 22.0,
                            ),
                            label: Text('Reply'),
                          ),
                        ]),
                      ]),
                    ),
                  );
                }
              }
            }));
  }
}
