import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'telas/home.dart';

void main() {
  runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        routes: {
          "/home": (context) => Home(),
        },
      )
  );
}
