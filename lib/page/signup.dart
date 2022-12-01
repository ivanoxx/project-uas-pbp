import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      drawer: leftDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text('Daftar Akun',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllerUsername,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    //obscureText: true,
                    controller: controllerPassword,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      suffixIcon: IconButton(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        splashRadius: 1,
                        icon: Icon(isPasswordVisible ?
                        Icons.visibility_outlined :
                        Icons.visibility_off_outlined
                        ),
                        onPressed: togglePasswordView,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){
                            const url = "http://127.0.0.1:8000/auth/register/";
                            //const url = "https://whistle-blower.up.railway.app/auth/register/";
                          final response = await request.login(url, {
                            "username" : controllerUsername.text,
                            "password" : controllerPassword.text}
                          );
                          if (response['instance'] == 'gagal Dibuat'){
                            showAlertDialog(context);
                          }
                          else {
                            showAlertDialog2(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 30),
                          textStyle: const TextStyle(
                            color: Colors.white,
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Coba Lagi"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignupPage()
          )
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Silakan gunakan username dan password lain!"),
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

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()
          )
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Akun Anda berhasil dibuat!\nSilakan login"),
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