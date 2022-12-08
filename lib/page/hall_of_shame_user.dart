import 'package:flutter/material.dart';
import 'package:whistleblower/utils/FetchHallOfShame.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/all_page.dart';

class HallOfShameUserPage extends StatefulWidget {
  const HallOfShameUserPage({super.key});

  @override
  State<HallOfShameUserPage> createState() => _HallOfShameUserPageState();
}

class _HallOfShameUserPageState extends State<HallOfShameUserPage> {
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
      body: FutureBuilder(
        future: fetchHallOfShame(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data.length < 1) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  const Text(
                    "Hall Of Shame kosong!",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailHallOfShamePage(
                              hallOfShame: snapshot.data![index]),
                        ),
                      ),
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
                          border: Border.all(color: Colors.white),
                        ),
                        child: Column(children: [
                          Row(children: [
                            Text(
                              "${snapshot.data![index].fields.name}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            Text(
                              "Arrested date: ${snapshot.data![index].fields.arrestedDate}",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            )
                          ]),
                          Row(children: [
                            Text(
                              "Corruption type: ${snapshot.data![index].fields.corruptionType}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            )
                          ]),
                          Row(children: [
                            Text(
                              snapshot.data![index].fields.description.length <
                                      60
                                  ? "Description: ${snapshot.data![index].fields.description}"
                                  : "Description: ${snapshot.data![index].fields.description.substring(0, 61)}... read more",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            )
                          ]),
                          const SizedBox(height: 20),
                        ]),
                      ),
                    ),
                  );
            }
          }
        },
      ),
    );
  }
}
