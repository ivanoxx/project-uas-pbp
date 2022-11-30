import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyForumFormPage extends StatefulWidget {
  const MyForumFormPage({super.key});

  @override
  State<MyForumFormPage> createState() => _MyForumFormPageState();
}

class _MyForumFormPageState extends State<MyForumFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nama = "";
  String _description = "";
  RegExp regexNama = RegExp(r'^[A-Za-z0-9._~-]*$');

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var listNama = ["###"];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Forum"),
          actions: [
            profilePicture(),
          ],
        ),
        drawer: leftDrawer(),
        endDrawer: rightDrawer(),
        body: FutureBuilder(
          future: request.get(
              "https://whistle-blower.up.railway.app/create-forum/name/"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              for (int i = 0; i < snapshot.data!["name_list"].length; i++) {
                listNama[i] = snapshot.data!["name_list"][i][0];
              }
            }
            return Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "manusia-jahat",
                          labelText: "Nama Forum",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // TODO Implement onChanged dan onSaved
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _nama = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _nama = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama forum tidak boleh kosong!';
                          } else if (!regexNama.hasMatch(value)) {
                            return 'Masukkan nama forum yang sesuai (hanya alphanumeric (case sensitive), ".", "_", "~", dan "-").';
                          } else if (listNama.contains(value)) {
                            return "Nama forum sudah pernah digunakan";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Forum ini isinya orang-orang jahat",
                          labelText: "Description",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // TODO Implement onChanged dan onSaved
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
        );
  }
}
