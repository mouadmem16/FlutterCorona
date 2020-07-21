import 'package:covid_bdcc2/services/HttpClient.dart';
import 'package:covid_bdcc2/services/callMsgService.dart';
import 'package:flutter/material.dart';
import 'package:covid_bdcc2/screens/screens.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerSingleton<CallsAndMessagesService>(CallsAndMessagesService());
  GetIt.I.registerSingleton<HttpClient>(HttpClient());
}

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 BDCC2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
    );
  }
}
