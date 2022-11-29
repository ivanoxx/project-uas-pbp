import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MyPostFormPage extends StatefulWidget {
  const MyPostFormPage({super.key});

  @override
  State<MyPostFormPage> createState() => _MyPostFormPageState();
}

class _MyPostFormPageState extends State<MyPostFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            profilePicture(),
          ],
        ),
        drawer: leftDrawer(),
        endDrawer: rightDrawer(),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
