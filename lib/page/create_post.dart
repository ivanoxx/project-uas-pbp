import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


class MyPostFormPage extends StatefulWidget {
  const MyPostFormPage({super.key});

  @override
  State<MyPostFormPage> createState() => _MyPostFormPageState();
}

class _MyPostFormPageState extends State<MyPostFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String _nama = "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
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
                              return 'Judul tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
