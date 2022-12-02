//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:whistleblower/utils/allUtils.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'login.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});
  

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

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
        body: Container(
          child: Text('PAGE COMMENT',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            )),
        )
    );
  }
}