import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'login.dart';
import 'package:whistleblower/page/all_page.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.group_name});
  final group_name;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.group_name),
          actions: const [
            profilePicture(),
          ],
        ), // Menambahkan drawer menu
        drawer: const leftDrawer(),
        endDrawer: const rightDrawer(),
        body: FutureBuilder(
            future: fetchTimeline(request, widget.group_name),
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
                            //onTap: () => Navigator.pop(context),
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
                                      width: 3,
                                      color: snapshot
                                              .data![index].fields.isCaptured
                                          ? Colors.red
                                          : Colors.white)),
                              child: Column(children: [
                                Row(children: [
                                  Text(
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "Written by: Anonymous ${snapshot.data![index].fields.creator}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  )
                                ]),
                                Row(children: [
                                  Text(
                                    "${snapshot.data![index].fields.dateCreated}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )
                                ]),
                                Row(children: [
                                  Text(
                                    "${snapshot.data![index].fields.description}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )
                                ]),
                                Visibility(
                                  visible:
                                      snapshot.data![index].fields.isCaptured,
                                  child: Row(children: [
                                    Text(
                                      "Arrested date : ${snapshot.data![index].fields.dateCaptured}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 20),
                                Row(children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      if (request.loggedIn) {
                                        final url =
                                            "https://whistle-blower.up.railway.app/${snapshot.data![index].pk}/upvote/";
                                        final response = await request.get(url);
                                        setState(() {
                                          snapshot.data![index].fields
                                              .upvoteCount = response['upvote'];
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_circle_up_rounded,
                                      size: 22.0,
                                    ),
                                    label: Text(snapshot
                                        .data![index].fields.upvoteCount
                                        .toString()),
                                  ),
                                  SizedBox(width: 7),
                                  // TODO: buat ke comment
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (request.loggedIn) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentPage(
                                                        post: snapshot
                                                            .data![index])));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }

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
                          ));
                }
              }
            }));
  }
}
