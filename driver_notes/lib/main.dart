// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textController = TextEditingController();

  /*void addNewDrop() {
    setState(() {
      //textController.value = textController.value.copyWith(text: 'Drop 1');
    }); */

  void insertText(String insert, TextEditingController controller) {
    final int cursorPos = controller.selection.base.offset;
    controller.value = controller.value.copyWith(
        text: controller.text
            .replaceRange(max(cursorPos, 0), max(cursorPos, 0), insert),
        selection: TextSelection.fromPosition(
            TextPosition(offset: max(cursorPos, 0) + insert.length)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Driver Notes'),
          ),
          body: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Insert Starting Time'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Insert Finishing Time'),
              ),
              TextField(
                minLines: 10,
                maxLines: 10,
                controller: textController,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () => insertText('Drop 1', textController),
                      child: Text('Add Drop')),
                  IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                ],
              ),
            ],
          )),
    );
  }
}
