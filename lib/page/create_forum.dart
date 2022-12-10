import 'package:flutter/material.dart';
import 'package:whistleblower/main.dart';
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
          future: request
              .get("https://whistle-blower.up.railway.app/create-forum/name/"),
          // request.get( "https://whistle-blower.up.railway.app/create-forum/name/"),

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null && listNama[0] == "###") {
              for (int i = 0; i < snapshot.data!["name_list"].length; i++) {
                listNama.add(snapshot.data!["name_list"][i][0]);
              }
              listNama.removeAt(0);
            }
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          child: const Text(
                            'Buat Forum Anda Sendiri',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Nama Forum",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Description",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(500, 30),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                )),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                const url =
                                    "https://whistle-blower.up.railway.app/create-forum-flutter/";
                                final response = await request.post(url, {
                                  "title": _nama,
                                  "description": _description,
                                });
                                if (response["status"] == "oke") {
                                  // Do something
                                  showAlertDialog2(context);
                                  _formKey.currentState?.reset();
                                  _nama = "";
                                  _description = "";
                                } else {
                                  // Do something
                                }
                              }
                            },
                            child: const Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Whistleblower")));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Anda berhasil membuat forum baru"),
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
