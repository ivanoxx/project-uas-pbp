import 'package:flutter/material.dart';
import 'package:whistleblower/models/allModel.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/main.dart';
import 'package:whistleblower/utils/allUtils.dart';

class MyPostFormPage extends StatefulWidget {
  const MyPostFormPage({super.key});

  @override
  State<MyPostFormPage> createState() => _MyPostFormPageState();
}

class _MyPostFormPageState extends State<MyPostFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nama = "";
  String _description = "";
  RegExp regexNama = RegExp(r'^[A-Za-z0-9._~-]*$');
  var _selectedGroup = [];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    List<Forum> listNama = [];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: const [
            profilePicture(),
          ],
        ),
        drawer: leftDrawer(),
        endDrawer: rightDrawer(),
        body: FutureBuilder(
          future: fetchGroup(request),
          // request.get( "https://whistle-blower.up.railway.app/create-forum/name/"),

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              listNama = snapshot.data!;
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
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
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
                              return 'Nama post tidak boleh kosong!';
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
                      Container(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor.withOpacity(.4),
                          border: Border.all(
                            // color: Theme.of(context).primaryColor,
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            MultiSelectBottomSheetField(
                              initialChildSize: 0.4,
                              listType: MultiSelectListType.CHIP,
                              searchable: true,
                              buttonText: Text("Posted on"),
                              title: Text("Forum"),
                              items: listNama.map((Forum items) {
                                return MultiSelectItem(
                                    items.pk.toString(), items.fields.title);
                              }).toList(),
                              onConfirm: (values) {
                                setState(() {
                                  _selectedGroup = values;
                                });
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedGroup.remove(value);
                                  });
                                },
                              ),
                            ),
                            _selectedGroup == null || _selectedGroup.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "None selected",
                                      style: TextStyle(color: Colors.black54),
                                    ))
                                : Container(),
                          ],
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              const url =
                                  "http://127.0.0.1:8000/create-post-flutter/";
                              final response = await request.post(url, {
                                "title": _nama,
                                "description": _description,
                                "group" : _selectedGroup.toString(),
                              });
                              if (response["status"] == "oke") {
                                // Do something
                                showAlertDialog2(context);
                                _formKey.currentState?.reset();
                              } else {
                                // Do something
                                print("gagal");
                              }
                            }
                          },
                          child: const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white),
                          )),
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
