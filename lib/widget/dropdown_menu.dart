import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/my_post.dart';
import 'package:intl/intl.dart';

// Diambil dari https://pub.dev/packages/dropdown_button2

class CustomButtonTest extends StatefulWidget {
  final post;
  final callbackFunction;
  CustomButtonTest(
      {Key? key, required this.post, required this.callbackFunction})
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
          Icons.list,
          size: 46,
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
          MenuItems.onChanged(context, value as MenuItem, post);
          widget.callbackFunction();
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

  static onChanged(BuildContext context, MenuItem item, final post) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    var controllerNama = TextEditingController();
    var controllerDescription = TextEditingController();
    controllerNama.text = post.fields.title;
    controllerDescription.text = post.fields.description;
    DateTime dateCaptured = post.fields.dateCaptured ?? DateTime.now();
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
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Text("Captured? : "),
                              Checkbox(
                                  value: post.fields.isCaptured,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      post.fields.isCaptured = value!;
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Visibility(
                            visible: post.fields.isCaptured,
                            child: Row(
                              children: [
                                Text("Date Captured: "),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        left: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            DateFormat('EEEE, MMM d, yyyy')
                                                .format(dateCaptured),
                                          ),
                                          onTap: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: dateCaptured,
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime.now());
                                            if (newDate != null) {
                                              setState(() {
                                                post.fields.dateCaptured =
                                                    newDate;
                                                dateCaptured = newDate;
                                              });
                                            }
                                            ;
                                            // TODO: Masukin datenya
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          tooltip: 'Tap to open date picker',
                                          onPressed: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: dateCaptured,
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime.now());
                                            if (newDate != null) {
                                              setState(() {
                                                post.fields.dateCaptured =
                                                    newDate;
                                                dateCaptured = newDate;
                                              });
                                            }
                                            ;
                                            // TODO: Masukin datenya
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
        var url = 'http://127.0.0.1:8000/mypost/${post.pk}/delete/';
        // var url = 'https://whistle-blower.up.railway.app/mypost/$idPost/delete/';
        final response = await request.get(url);

        if (response['msg'] == "Success") {
          // TODO Do Something
        } else {
          // TODO Do something
        }
        //Do something
        break;
    }
  }
}
