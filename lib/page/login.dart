import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/all_page.dart';
import 'package:whistleblower/page/signup.dart';
import 'package:whistleblower/utils/FetchProfile.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'package:whistleblower/widget/allWidgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String username = "Anonymous";

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    // The rest of your widgets are down below
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        drawer: leftDrawer(),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      'Login anonymous user',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    )),
                Form(
                    key: _loginFormKey,
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _controllerUsername,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.account_circle),
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Username tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _controllerPassword,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(250, 250, 250, 0.95),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  splashRadius: 1,
                                  icon: Icon(isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePasswordView,
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Container(
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_loginFormKey.currentState!
                                        .validate()) {
                                      const url =
                                          "https://whistle-blower.up.railway.app/auth/login/";
                                      // const url = "https://whistle-blower.up.railway.app/auth/login/";

                                      final response = await request.login(
                                          url, {
                                        "username": _controllerUsername.text,
                                        "password": _controllerPassword.text
                                      });

                                      if (request.loggedIn) {
                                        username = _controllerUsername.text;

                                        final response =
                                            await fetchProfile(request);
                                        user_data = {
                                          "username": username,
                                          "alias": response[0].fields.alias,
                                          "imagePath":
                                              "https://whistle-blower.up.railway.app/images/${response[0].fields.image}"
                                        };
                                        showAlertDialog2(context);
                                      } else {
                                        showAlertDialog(context);
                                      }
                                    }
                                  },
                                  child: Text("Masuk"),
                                ))
                          ],
                        ))),
                Row(
                  children: <Widget>[
                    Flexible(
                        child: TextButton(
                      child: const Text(
                        'Daftar disini',
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ));
                      },
                    )),
                    const Text(
                      'apabila tidak memiliki akun',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            )));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Coba Lagi"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Username dan password tidak cocok!"),
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
    child: Text("Close"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'whistleblower',
                  )));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Anda berhasil login"),
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
