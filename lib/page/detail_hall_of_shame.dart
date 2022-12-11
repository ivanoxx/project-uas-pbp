// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/models/ModelHallOfShame.dart';
import 'package:whistleblower/utils/FetchProfile.dart';
import '../models/ModelProfile.dart';

class DetailHallOfShamePage extends StatefulWidget {
  const DetailHallOfShamePage({super.key, required this.hallOfShame});

  final HallOfShame hallOfShame;

  @override
  State<DetailHallOfShamePage> createState() => _DetailHallOfShamePageState();
}

class _DetailHallOfShamePageState extends State<DetailHallOfShamePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hall Of Shame"),
        actions: const [
          profilePicture(),
        ],
      ), // Menambahkan drawer menu
      drawer: const leftDrawer(),
      endDrawer: const rightDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                widget.hallOfShame.fields.name,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      children: <TextSpan>[
                        const TextSpan(
                          text: "Arrested Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.hallOfShame.fields.arrestedDate,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      children: <TextSpan>[
                        const TextSpan(
                          text: "Corruption Type: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.hallOfShame.fields.corruptionType,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      children: <TextSpan>[
                        const TextSpan(
                          text: "Description: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.hallOfShame.fields.description,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 90,
                      height: 40,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () async {
                          if (request.loggedIn) {
                            List<Profile> lst = await fetchProfile(request);
                            if (lst[0].fields.isAdmin) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HallOfShamePage()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HallOfShameUserPage()));
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                          // Here you can give your route to navigate
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
