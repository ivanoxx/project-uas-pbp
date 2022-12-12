// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/utils/FetchHallOfShame.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'package:regexed_validator/regexed_validator.dart';

class FormHallOfShamePage extends StatefulWidget {
  const FormHallOfShamePage({super.key});

  @override
  State<FormHallOfShamePage> createState() => _FormHallOfShamePageState();
}

class _FormHallOfShamePageState extends State<FormHallOfShamePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _arrestedDate = "";
  String _corruptionType = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Corruptor"),
          actions: const [
            profilePicture(),
          ],
        ),
        drawer: const leftDrawer(),
        endDrawer: const rightDrawer(),
        body: FutureBuilder(
          future: fetchHallOfShame(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {}
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
                              'Add Corruptor',
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
                              hintText: "Cth: Pak Korup",
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (String? value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong!';
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
                              hintText: "YYYY-MM-DD",
                              labelText: "Arrested Date",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (String? value) {
                              setState(() {
                                _arrestedDate = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _arrestedDate = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Tanggal tertangkap tidak boleh kosong!';
                              }

                              if (!isDateFormat(value) || !validator.date(value)) {
                                return 'Input harus dalam format YYYY-MM-DD!';
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
                              hintText: "Cth: Suap",
                              labelText: "Corruption Type",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (String? value) {
                              setState(() {
                                _corruptionType = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _corruptionType = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Tipe korupsi tidak boleh kosong!';
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
                              hintText: "Cth: Pak Korup menyuap hakim agar tidak dipenjara",
                              labelText: "Description",
                              // Menambahkan circular border agar lebih rapi
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 250, 0.95),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                const url =
                                    "https://whistle-blower.up.railway.app/hall/add-flutter/";
                                final response = await request.post(url, {
                                  "name": _name,
                                  "arrested_date": _arrestedDate,
                                  "corruption_type": _corruptionType,
                                  "description": _description,
                                });
                                if (response["status"] == "oke") {
                                  showAlertDialogHall(context);
                                  _formKey.currentState?.reset();
                                } else {
                                  showAlertDialogHall2(context);
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
              ),
            );
          },
        ));
  }

  bool isDateFormat(String date) {
    try {
      DateTime.parse(date);
      return true;
    } on FormatException {
      return false;
    } catch (e) {
      return false;
    }
  }

  showAlertDialogHall(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Close"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HallOfShamePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Selamat!"),
      content: const Text("Anda berhasil menambahkan informasi koruptor!"),
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

  static showAlertDialogHall2(BuildContext context) {
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
}
