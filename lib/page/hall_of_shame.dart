// import 'package:flutter/material.dart';
// import 'package:whistleblower/widget/allWidgets.dart';
// import 'package:provider/provider.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:whistleblower/page/form_hall_of_shame.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:whistleblower/models/ModelHallOfShame.dart';

// List<Widget> listData = [];

// class HallOfShamePage extends StatefulWidget {
//   const HallOfShamePage({super.key});

//   @override
//   State<HallOfShamePage> createState() => _HallOfShamePageState();
// }

// class _HallOfShamePageState extends State<HallOfShamePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Hall Of Shame"),
//         actions: [
//           profilePicture(),
//         ],
//       ),
//       drawer: leftDrawer(),
//       endDrawer: rightDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20, left: 20),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: SizedBox(
//                   width: 110,
//                   height: 40,
//                   child: TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.blue),
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const FormHallOfShamePage()));
//                     },
//                     child: const Text(
//                       "Add Corruptor",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: listData,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:whistleblower/utils/FetchHallOfShame.dart';
import 'package:whistleblower/widget/allWidgets.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:whistleblower/page/form_hall_of_shame.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whistleblower/models/ModelHallOfShame.dart';

List<Widget> listData = [];

class HallOfShamePage extends StatefulWidget {
  const HallOfShamePage({super.key});

  @override
  State<HallOfShamePage> createState() => _HallOfShamePageState();
}

class _HallOfShamePageState extends State<HallOfShamePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hall Of Shame"),
        actions: const [
          profilePicture(),
        ],
      ), // Menambahkan drawer menu
      drawer: const leftDrawer(),
      endDrawer: const rightDrawer(),
      body: FutureBuilder(
        future: fetchHallOfShame(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "hall Of Shame kosong",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () => Navigator.pop(context),
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
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(children: [
                      Row(children: [
                        Text(
                          "${snapshot.data![index].fields.name}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Text(
                          "Arrested date: ${snapshot.data![index].fields.arrestedDate}",
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        )
                      ]),
                      Row(children: [
                        Text(
                          "Corruption type: ${snapshot.data![index].fields.corruptionType}",
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        )
                      ]),
                      Row(children: [
                        Text(
                          "Description: ${snapshot.data![index].fields.description}",
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        )
                      ]),
                      SizedBox(height: 20),
                    ]),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

          // Padding(
          //   padding: const EdgeInsets.only(top: 20, left: 20),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: SizedBox(
          //       width: 110,
          //       height: 40,
          //       child: TextButton(
          //         style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(Colors.blue),
          //         ),
          //         onPressed: () {
          //           Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const FormHallOfShamePage()));
          //         },
          //         child: const Text(
          //           "Add Corruptor",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
