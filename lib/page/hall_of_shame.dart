// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:whistleblower/utils/FetchHallOfShame.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/all_page.dart';

class HallOfShamePage extends StatefulWidget {
  const HallOfShamePage({super.key});

  @override
  State<HallOfShamePage> createState() => _HallOfShamePageState();
}

class _HallOfShamePageState extends State<HallOfShamePage> {
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
            return Column(
              children: [
                addButton(),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            if (snapshot.data!.length < 1) {
              return Column(
                children: [
                  addButton(),
                  const Text(
                    "hall Of Shame kosong!",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        addButton(),
                        cardCorruptor(index, snapshot, request),
                      ],
                    );
                  }
                  return cardCorruptor(index, snapshot, request);
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget addButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 18),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 110,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const FormHallOfShamePage()),
              );
            },
            child: const Text(
              "Add Corruptor",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardCorruptor(
      int index, AsyncSnapshot snapshot, CookieRequest request) {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailHallOfShamePage(hallOfShame: snapshot.data![index]),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2.0)],
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${snapshot.data![index].fields.name}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Arrested date: ${snapshot.data![index].fields.arrestedDate}",
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Corruption type: ${snapshot.data![index].fields.corruptionType}",
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    snapshot.data![index].fields.description.length < 40
                        ? "Description: ${snapshot.data![index].fields.description}"
                        : "Description: ${snapshot.data![index].fields.description.substring(0, 40)}... read more",
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 70,
              height: 30,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  var id = snapshot.data![index].pk;
                  var url =
                      "https://whistle-blower.up.railway.app/hall/delete-flutter/$id/";
                  final response = await request.get(url);
                  if (response['status'] == "oke") {
                    showAlertDialogHall4(context);
                    setState(() {});
                  } else {
                    showAlertDialogHall3(context);
                  }
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showAlertDialogHall3(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Coba Lagi"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Gagal!"),
      content: const Text("Terjadi suatu kesalahan"),
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

  static showAlertDialogHall4(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Close"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Selamat!"),
      content: const Text("Anda berhasil Delete Card"),
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
}
