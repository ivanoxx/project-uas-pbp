import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/utils/FetchProfile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<Response> saveEdit(File? file, String alias, CookieRequest request) async {
    var id = (await fetchUserData(request))[0].fields.user;
    var imageFile;
    try {
      String fileName = file!.path.split('/').last;
      imageFile = await MultipartFile.fromFile(file.path, filename: fileName);
    } catch (e) {
      imageFile = "";
    }
    FormData formData = FormData.fromMap({
      "alias": alias,
      "newProfpic": imageFile,
    });
    var response = await Dio().post(
        "https://whistle-blower.up.railway.app/myprofile/edit-flutter",
        data: formData,
        queryParameters: {"id": id});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProfileWidget(
                      imagePath: image == null ? imagePath : image!.path,
                      isEdit: true,
                      // TODO: Edit profpic
                      onClicked: () => pickImage(),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Alias",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: user_data["alias"],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (String? value) {
                        setState(() {
                          user_data["alias"] = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          user_data["alias"] = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Alias tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () async {
                        final response = await saveEdit(image, user_data["alias"]!, request);
                        if (response.statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          showAlertDialog(context);
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Profile berhasil di-edit!"),
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
