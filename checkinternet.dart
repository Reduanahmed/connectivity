import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future CheckInternetConection() async {
  final ConnectivityResult result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.wifi) {
    Fluttertoast.showToast(msg: "Connected with Wifi");
  } else if (result == ConnectivityResult.mobile) {
    Fluttertoast.showToast(msg: "Connected with Mobile");
  } else {
    Fluttertoast.showToast(msg: "No Internet Connection");
  }
}

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? _subscription;
  @override
  void initState() {
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      CheckInternetConection();
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Do you want to check your Internet connection?",
              style: TextStyle(fontSize: 19),
            ),
            Text(
              "Here you can check your Internet connection",
              style: TextStyle(fontSize: 17),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            OutlinedButton(
              onPressed: CheckInternetConection,
              child: Text('Cheak Connection'),
            )
          ],
        ),
      ),
    );
  }
}
