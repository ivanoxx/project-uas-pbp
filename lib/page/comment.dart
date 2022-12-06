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
  Widget build(BuildContext context){
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
        drawer: const leftDrawer(),
        endDrawer: const rightDrawer(),
        // TODO: Taro Form di sini
        bottomNavigationBar: Form(
          key: _formKey,
          child: Row(
            children: [Text("Test")],
          ),
        ),

        body: FutureBuilder(
          future: fetchComment(request, widget.post),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text("Test");
          },

        )
    );
  }
}