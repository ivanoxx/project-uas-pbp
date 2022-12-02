import 'package:flutter/material.dart';
import 'package:whistleblower/widget/drawers.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/models/ModelForum.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:whistleblower/utils/allUtils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Whistleblower',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: Color.fromRGBO(44, 51, 51, 1)),
        home: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          profilePicture(),
        ],
      ),
      drawer: leftDrawer(),
      // Diambil dari https://blogmarch.com/flutter-left-right-navigation-drawer/
      endDrawer: rightDrawer(),
      body: FutureBuilder(
          future: fetchGroup(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: Column(
                children: [
                  // TODO: Ganti test jadi sesuatu yang lu mau
                  Text("test"),
                  CircularProgressIndicator()],
              ));
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    // TODO: Masukin gambar atau apa yang lu mau
                    Text(
                      "Anda Tidak memiliki forum :(",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            // TODO: Ganti test jadi apa yang mau lu tampilkan
                            Text("Test"),
                            InkWell(
                              // TODO : onTap harusnya push ke page timeline
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black, blurRadius: 2.0)
                                  ],
                                  // border: Border.all(
                                  //     color:
                                  //     snapshot.data![index].fields.isCaptured
                                  //         ? Colors.white
                                  //         : Colors.red)
                                ),
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
                                  SizedBox(height: 20),
                                  Row(children: [
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_circle_up_rounded,
                                        size: 22.0,
                                      ),
                                      label: Text('Upvote'),
                                    ),
                                    SizedBox(width: 7),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_comment_rounded,
                                        size: 22.0,
                                      ),
                                      label: Text('Reply'),
                                    ),
                                  ]),
                                ]),
                              ),
                            )
                          ],
                        );
                      }
                      return InkWell(
                        // TODO : onTap harusnya push ke page timeline
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 2.0)
                            ],
                            // border: Border.all(
                            //     color:
                            //     snapshot.data![index].fields.isCaptured
                            //         ? Colors.white
                            //         : Colors.red)
                          ),
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
                            SizedBox(height: 20),
                            Row(children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  size: 22.0,
                                ),
                                label: Text('Upvote'),
                              ),
                              SizedBox(width: 7),
                              ElevatedButton.icon(
                                onPressed: () {},
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
                    });
              }
            }
          }),
    );
  }
}
