//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'login.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.post});
  final post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  String _nama = "";

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Comment',
          ),
          actions: const [
            profilePicture(),
          ],
        ), // Menambahkan drawer menu
        //drawer: const leftDrawer(),
        endDrawer: const rightDrawer(),
        // Form buat isi comment
        bottomNavigationBar: Form(
          key: _formKey,
          child: Container(
            //padding: EdgeInsets.all(5.0),
            padding: MediaQuery.of(context).viewInsets,
            decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 0.95),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 3)),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: 'Write a comment..',
                prefixIcon: Icon(Icons.add_comment_rounded),
                suffixIcon: IconButton(
                    splashRadius: 1,
                    icon: Icon(Icons.send_sharp),
                    onPressed: () async {
                      if (!request.loggedIn) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      } else {
                        if (_formKey.currentState!.validate()) {
                          String url =
                              "https://whistle-blower.up.railway.app/mypost/${widget.post.pk}/comment/add/";
                          final response =
                              await request.post(url, {'comment': _nama});
                          if (response['msg'] == 'success') {
                            _formKey.currentState?.reset();
                            _nama = "";
                            setState(() {});
                            showAlertDialog2Comment(context);
                          } else {
                            showAlertDialogComment(context);
                          }
                        }
                      }
                      ;
                    }),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(200, 200, 200, 1),
                ),
              ),
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
            ),
          ),
        ),
        body: FutureBuilder(
            future: fetchComment(request, widget.post),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return (CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2.0)
                              ],
                            ),
                            child: Column(children: [
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${widget.post.fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "Written by: Anonymous ${widget.post.fields.creator}",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ))
                              ]),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "Created: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCreated.toString()))}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ))
                              ]),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${widget.post.fields.description}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ))
                              ]),
                              Visibility(
                                visible: widget.post.fields.isCaptured,
                                child: Row(children: [
                                  Flexible(
                                    child: Text(
                                      "Arrested date : ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCaptured == null ? DateTime.now().toString() : widget.post.fields.dateCaptured.toString()))}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ]),
                          ),
                        ),
                        const Center(child: CircularProgressIndicator()),
                      ]),
                    )
                  ],
                ));
              } else {
                if (snapshot.data!.length == 0) {
                  return Column(
                    children: [
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 2.0)
                                ],
                                border: Border.all(
                                    width: 3,
                                    color: widget.post.fields.isCaptured
                                        ? Colors.red
                                        : Colors.white)),
                            child: Column(children: [
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${widget.post.fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "Written by: Anonymous ${widget.post.fields.creator}",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ))
                              ]),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "Created: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCreated.toString()))}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ))
                              ]),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${widget.post.fields.description}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ))
                              ]),
                              Visibility(
                                visible: widget.post.fields.isCaptured,
                                child: Row(children: [
                                  Flexible(
                                    child: Text(
                                      "Arrested date : ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCaptured == null ? DateTime.now().toString() : widget.post.fields.dateCaptured.toString()))}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                      // TODO: Masukin gambar atau apa yang lu mau
                      Column(
                        children: const [
                          SizedBox(
                            height: 50,
                          ),
                          
                          Center(
                            child: Text(
                              "Post tidak memiliki komentar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      )
                    ],
                  );
                } else {
                  // card-card untuk commentnya
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 2.0)
                                        ],
                                        border: Border.all(
                                            width: 3,
                                            color: widget.post.fields.isCaptured
                                                ? Colors.red
                                                : Colors.white)),
                                    child: Column(children: [
                                      Row(children: [
                                        Flexible(
                                            child: Text(
                                          "${widget.post.fields.title}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Flexible(
                                            child: Text(
                                          "Written by: Anonymous ${widget.post.fields.creator}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ))
                                      ]),
                                      Row(children: [
                                        Flexible(
                                            child: Text(
                                          "Created: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCreated.toString()))}",
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ))
                                      ]),
                                      Row(children: [
                                        Flexible(
                                            child: Text(
                                          "${widget.post.fields.description}",
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ))
                                      ]),
                                      Visibility(
                                        visible: widget.post.fields.isCaptured,
                                        child: Row(children: [
                                          Flexible(
                                            child: Text(
                                              "Arrested date : ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(widget.post.fields.dateCaptured == null ? DateTime.now().toString() : widget.post.fields.dateCaptured.toString()))}",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),

                              //
                              Text(
                                'Comment\n',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'AbrilFatface',
                                    color: Colors.white),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 7),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: index % 2 != 0
                                      ? Colors.white
                                      : Color.fromARGB(255, 255, 77, 64),
                                  borderRadius: BorderRadius.circular(13.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2.0)
                                  ],
                                ),
                                child: Column(children: [
                                  Row(children: [
                                    Flexible(
                                        child: Text(
                                      "Anonymous ${snapshot.data![index].fields.user}",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                                  ]),
                                  SizedBox(height: 5),
                                  Row(children: [
                                    Flexible(
                                        child: Text(
                                      "${snapshot.data![index].fields.dateCreated}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ))
                                  ]),
                                  SizedBox(height: 7),
                                  Row(children: [
                                    Flexible(
                                        child: Text(
                                      "${snapshot.data![index].fields.comment}",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ))
                                  ]),
                                  SizedBox(height: 20),
                                ]),
                              ),
                              //SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: index % 2 != 0
                                  ? Colors.white
                                  : Color.fromARGB(255, 255, 77, 64),
                              borderRadius: BorderRadius.circular(13.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2.0)
                              ],
                            ),
                            child: Column(children: [
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "Anonymous ${snapshot.data![index].fields.user}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 5),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${snapshot.data![index].fields.dateCreated}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 7),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  "${snapshot.data![index].fields.comment}",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 20),
                            ]),
                          );
                        }
                      });
                }
              }
            }));
  }
}

showAlertDialogComment(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Belum berhasil menambahkan komentar!"),
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

showAlertDialog2Comment(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Close"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Anda berhasil memberikan komentar!"),
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
