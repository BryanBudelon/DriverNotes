// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
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

  void showModalOptions(BuildContext ctx) {
    /*showModalBottomSheet(
        context: ctx,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Card(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  children: [],
                ),
              ),
            ),
          );
        });
        */
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(children: [
                  GestureDetector(
                    child: Text('No parking spot nearby'),
                    onTap: () {
                      setState(() {
                        insertText('\nNo parking spot nearby', textController);
                      });
                    },
                  )
                ]),
                color: Colors.teal[100],
              ),
            ],
          );
        });
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
                onSubmitted: (_) =>
                    insertText(textController.text, textController),
              ),
              Row(
                children: [
                  ElevatedButton(
                      //onPressed: () => insertText('Drop \n', textController),
                      onPressed: () => showModalOptions(context),
                      child: Text('Add Drop')),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: textController.text));
                      },
                      icon: Icon(Icons.copy)),
                ],
              ),
            ],
          )),
    );
  }
}
