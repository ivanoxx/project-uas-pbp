import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/page/my_post.dart';
import 'package:intl/intl.dart';

// Diambil dari https://pub.dev/packages/dropdown_button2

class CustomButtonTest extends StatefulWidget {
  final post;
  final setPageState;
  final setPostStateInput;
  CustomButtonTest(
      {Key? key,
      required this.post,
      required this.setPageState,
      required this.setPostStateInput})
      : super(key: key);

  // Child({this.function});

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final post = widget.post;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.more_vert,
          size: 30,
          color: Colors.red,
        ),
        customItemsHeights: [
          ...List<double>.filled(MenuItems.firstItems.length, 48),
          8,
          ...List<double>.filled(MenuItems.secondItems.length, 48),
        ],
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem, post,
              widget.setPageState, widget.setPostStateInput);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.redAccent,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit];
  static const List<MenuItem> secondItems = [delete];

  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem(text: 'Edit', icon: Icons.mode_edit);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, final post,
      final setPageState, final setPostStateInput) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    var controllerNama = TextEditingController();
    var controllerDescription = TextEditingController();
    var controllerDate = TextEditingController();
    controllerNama.text = post.fields.title;
    controllerDescription.text = post.fields.description;
    DateTime dateCaptured = post.fields.dateCaptured == null
        ? DateTime.now()
        : DateTime.parse(post.fields.dateCaptured);
    controllerDate.text = DateFormat('EEEE, MMM d, yyyy').format(dateCaptured);
    switch (item) {
      case MenuItems.edit:
        //Do something
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, StateSetter setState) {
                return AlertDialog(
                  content: Form(
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // TODO Implement onChanged dan onSaved
                              // Menambahkan behavior saat nama diketik
                              controller: controllerNama,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // Menambahkan behavior saat nama diketik
                              controller: controllerDescription,
                              // Validator sebagai validasi form
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Deskripsi tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Captured? : "),
                                Checkbox(
                                    value: post.fields.isCaptured,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        post.fields.isCaptured = value!;
                                        post.fields.dateCaptured = dateCaptured.toString();
                                      });
                                    }),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: post.fields.isCaptured,
                              child: TextField(
                                controller: controllerDate,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  labelText:
                                      "Enter Date Captured", //label text of field
                                  suffixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: dateCaptured,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());
                                  if (newDate != null) {
                                    setState(() {
                                      post.fields.dateCaptured = newDate;
                                      dateCaptured = newDate;
                                      controllerDate.text =
                                          DateFormat('EEEE, MMM d, yyyy')
                                              .format(dateCaptured);
                                    });
                                  }
                                  ;
                                  // TODO: Masukin datenya
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final url =
                                        'https://whistle-blower.up.railway.app/mypost/${post.pk}/edit/flutter/';
                                    try {
                                      final response = await request.post(url, {
                                        "name": controllerNama.text,
                                        "description":
                                            controllerDescription.text,
                                        "id": post.pk.toString(),
                                        "is_captured":
                                            post.fields.isCaptured.toString(),
                                        "date_captured":
                                            post.fields.dateCaptured.toString(),
                                      });
                                      if (response['msg'] == "success") {
                                        showAlertDialog2(context, "edit");
                                        setPostStateInput(
                                            controllerNama.text,
                                            controllerDescription.text,
                                            post.fields.isCaptured,
                                            post.fields.dateCaptured.toString());
                                      } else {
                                        showAlertDialog(context);
                                      }
                                      ;
                                    } catch (e) {
                                      showAlertDialog(context);
                                    }
                                  }
                                },
                                child: Text("Submit")),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            });
        break;
      case MenuItems.delete:
        var url =
            'https://whistle-blower.up.railway.app/mypost/${post.pk}/delete/';
        // var url = 'https://whistle-blower.up.railway.app/mypost/$idPost/delete/';
        final response = await request.get(url);
        if (response['msg'] == "Success") {
          // TODO Do Something
          showAlertDialog2(context, "Delete");
          setPageState();
        } else {
          // TODO Do something
          showAlertDialog(context);
        }
        //Do something
        break;
    }
  }

  static showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Coba Lagi"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Gagal!"),
      content: Text("Terjadi suatu kesalahan"),
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

  static showAlertDialog2(BuildContext context, text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        try {
          if (text == "edit") {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            Navigator.of(context, rootNavigator: true).pop('dialog');
          } else {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          }
        } catch (e) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyPostPage()));
        }
        

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Anda berhasil $text Post"),
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
