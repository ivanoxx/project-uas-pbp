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
            Builder(
              builder: (context) => IconButton(
                icon: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
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
