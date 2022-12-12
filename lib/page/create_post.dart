import 'package:flutter/material.dart';
import 'package:whistleblower/models/allModel.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              listNama = snapshot.data!;
            }
            return SingleChildScrollView(
              child: Padding(
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
                              'Buat Post Anda Sendiri',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Padding(
                          // Menggunakan padding sebesar 8 pixels
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Nama Post",

                              // Menambahkan circular border agar lebih rapi
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              filled: true,
                              hintText: "Description",

                              // Menambahkan circular border agar lebih rapi
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Theme.of(context).primaryColor.withOpacity(.4),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                MultiSelectBottomSheetField(
                                  initialChildSize: 0.4,
                                  listType: MultiSelectListType.CHIP,
                                  selectedColor: Colors.red,
                                  selectedItemsTextStyle: TextStyle(
                                    color: Colors.white,
                                  ),

                                  searchable: true,
                                  buttonText: Text("Posted on"),
                                  title: Text("Forum"),
                                  items: listNama.map((Forum items) {
                                    return MultiSelectItem(items.pk.toString(),
                                        items.fields.title);
                                  }).toList(),
                                  validator: (values) {
                                    if (values == null || values.isEmpty) {
                                      return "Forum Post tidak boleh kosong!";
                                    }
                                    return null;
                                  },
                                  onConfirm: (values) {
                                    setState(() {
                                      _selectedGroup = values;
                                    });
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    chipColor: Colors.red,
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
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ))
                                    : Container(),
                              ],
                            ),
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
                                      "https://whistle-blower.up.railway.app/create-post-flutter/";
                                  final response = await request.post(url, {
                                    "title": _nama,
                                    "description": _description,
                                    "group": _selectedGroup.toString(),
                                  });
                                  if (response["status"] == "oke") {
                                    // Do something
                                    showAlertDialog2(context);
                                    _formKey.currentState?.reset();
                                    _nama = "";
                                    _description = "";
                                    _selectedGroup = [];
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
                        ),
                      ],
                    ),
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
      content: Text("Anda berhasil membuat postingan baru"),
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
