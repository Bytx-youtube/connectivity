import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = " ";

  late StreamSubscription subscription;

  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if(result == ConnectivityResult.mobile) {
      setState(() {
        status = "Mobile Network";
      });
    } else if(result == ConnectivityResult.wifi){
      setState(() {
        status = "WiFi Network";
      });
    }
  }

  @override
  void initState() {
    checkConnectivity();

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connectivity changed to " + result.name),
        ),
      );
      setState(() {
        status = result.name;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Status " + status,
        ),
      ),
    );
  }
}
