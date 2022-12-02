import 'package:flutter/material.dart';
import 'package:whistleblower/models/ModelHallOfShame.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/models/allModel.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/main.dart';
import 'package:whistleblower/utils/allUtils.dart';

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
    List<HallOfShame> listHall = [];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Corruptor"),
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
              listHall = snapshot.data!;
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
                            'Add Corruptor',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Pak Korup",
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: "YYYY-MM-DD",
                            labelText: "Arrested Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Suap",
                            labelText: "Corruption Type",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              const url = "";
                              // "http://127.0.0.1:8000/create-hallofshame-flutter/";
                              final response = await request.post(url, {
                                "name": _name,
                                "arrested_date": _arrestedDate,
                                "corruption_type": _corruptionType,
                                "description": _description,
                              });
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
}
