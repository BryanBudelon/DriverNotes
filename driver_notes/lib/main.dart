// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:driver_notes/screens/home_screen.dart';
import 'package:driver_notes/screens/notes_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'widgets/insert_text.dart';
import 'widgets/reason_selection.dart';

/* 

Ajustar main.dart pra somente carregar a tela principal
Usar como base o projeto do MeliDeals.

*/

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          tabBarTheme: TabBarTheme(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
