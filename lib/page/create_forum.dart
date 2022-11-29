import 'package:flutter/material.dart';
import 'package:whistleblower/widget/allWidgets.dart';

class MyForumFormPage extends StatefulWidget {
  const MyForumFormPage({super.key});

  @override
  State<MyForumFormPage> createState() => _MyForumFormPageState();
}

class _MyForumFormPageState extends State<MyForumFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Forum"),
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
