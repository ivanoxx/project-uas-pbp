import 'package:flutter/material.dart';
import 'package:whistleblower/widget/drawers.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Whistleblower',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Color.fromRGBO(44,51,51,1)
        ),
        home: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
        actions: [
          profilePicture(),
        ],
      ),
      drawer: leftDrawer(),
      // Diambil dari https://blogmarch.com/flutter-left-right-navigation-drawer/
      endDrawer: rightDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,170,0,0),
                child: Image.asset('lib/assets/images/landing.png',
                  scale: 0.8
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,190),
                child: Text(
                  'Whistleblower',
                  style: TextStyle(
                    fontFamily: 'AbrilFatface', 
                    fontSize: 60, 
                    color: Colors.white),
                ),
              ),
              Text(
                'Forum',
                style: TextStyle(
                  fontFamily: 'AbrilFatface', 
                  fontSize: 30, 
                  color: Colors.white),
              ),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Title',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Descriptionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}





