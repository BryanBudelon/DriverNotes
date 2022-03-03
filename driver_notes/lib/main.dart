// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:driver_notes/notes_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'insert_text.dart';
import 'reason_selection.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final startDate = TextEditingController();
  final startTime = TextEditingController();
  final finishDate = TextEditingController();
  final finishTime = TextEditingController();
  final textController = TextEditingController();
  final dropController = TextEditingController();
  // final List<TextEditingController> test1 = [];
  String dropNumber = '';
  int selectedCard = -1;

  List<String> reasons = [
    'No parking spot neaby',
    'Customer\'s unit on level 1'
  ];

  @override
  void dispose() {
    //Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    startDate.dispose();
    super.dispose();
  }

  void showModalOptions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Text(reasons[0]),
                    onTap: () {
                      setState(
                        () {
                          dropNumber = dropController.text;
                          InsertText().insertText(
                              '\nDrop $dropNumber \nNo parking spot nearby',
                              textController);
                          Navigator.of(ctx).pop();
                        },
                      );
                    },
                  ),
                  color: Colors.teal[100],
                ),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Text(reasons[1]),
                    onTap: () {
                      setState(
                        () {
                          dropNumber = dropController.text;
                          InsertText().insertText(
                              '\nDrop $dropNumber \nCustomer\'s unit on level 2',
                              textController);
                          Navigator.of(ctx).pop();
                        },
                      );
                    },
                  ),
                  color: Colors.teal[100],
                ),
              ],
            ),
          );
        });
  }

  void reasonsList() {
    GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text('No parking spot nearby'),
            onTap: () {
              setState(
                () {
                  dropNumber = dropController.text;
                  InsertText().insertText(
                      '\nDrop $dropNumber \nNo parking spot nearby',
                      textController);
                },
              );
            },
          ),
          color: Colors.teal[100],
        ),
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text('Customer\'s unit on level 2'),
            onTap: () {
              setState(
                () {
                  dropNumber = dropController.text;
                  InsertText().insertText(
                      '\nDrop $dropNumber \nCustomer\'s unit on level 2',
                      textController);
                },
              );
            },
          ),
          color: Colors.teal[100],
        ),
      ],
    );
  }

  void _startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        print('Entrou no if');
        return;
      }
      setState(() {
        startDate.text = DateFormat('dd/MM/yy').format(pickedDate);
        print('Start Date:' + startDate.text);
      });
    });
  }

  void _finishDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        print('Entrou no if');
        return;
      }
      setState(() {
        finishDate.text = DateFormat('dd/MM/yy').format(pickedDate);
        print('Start Date:' + startDate.text);
      });
    });
  }

  void _startTimePicker() {
    showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        startTime.text = pickedTime.format(context);
        print('Start Time:' + startTime.text);
      });
    });
  }

  void _finishTimePicker() {
    showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        finishTime.text = pickedTime.format(context);
        print('Start Time:' + startTime.text);
      });
    });
  }

  Widget listingReasons() {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Text(''),
          onTap: () {
            setState(
              () {
                dropNumber = dropController.text;
                InsertText().insertText(
                    '\nDrop $dropNumber \nNo parking spot nearby',
                    textController);
              },
            );
          },
        ),
        color: Colors.teal[100]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Driver Notes'),
            bottom: TabBar(
              tabs: [
                Icon(Icons.notes),
                Icon(Icons.ac_unit),
              ],
            ),
          ),
          body: TabBarView(children: [
            // Action Tab
            Column(
              children: [
                Row(children: [
                  Container(
                    padding: EdgeInsets.only(left: 50.0),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Starting Date'),
                        controller: startDate,
                        onTap: _startDatePicker,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Starting Time'),
                      controller: startTime,
                      onTap: _startTimePicker,
                    ),
                  ),
                ]),
                Row(children: [
                  Container(
                    padding: EdgeInsets.only(left: 50.0),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Finising Date'),
                        controller: finishDate,
                        onTap: _finishDatePicker,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Finising Time'),
                      controller: finishTime,
                      onTap: _finishTimePicker,
                    ),
                  ),
                ]),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 50.0),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.25),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Drop Number',
                        suffixIcon: Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Row(children: [
                            IconButton(
                              icon: Icon(
                                Icons.add,
                              ),
                              onPressed: () {
                                var value = int.parse(dropController.text);
                                dropController.text = (value + 1).toString();
                                if (dropController.text.isNotEmpty) {
                                  value += 1;
                                  dropController.text = value.toString();
                                } else {
                                  String newText = (0 + 1).toString();
                                  dropController.value = TextEditingValue(
                                      text: newText,
                                      selection: TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  dropController.text.length)));
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                var value = int.parse(dropController.text);
                                dropController.text = (value - 1).toString();
                              },
                            ),
                          ]),
                        )),
                    keyboardType: TextInputType.number,
                    controller: dropController,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: ReasonSelection(textController, dropController)),
                ),
                /*Container(
                  width: 300,
                  height: 300,
                  child: GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    children: [
                      ReasonSelection(),
                      /*Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Text('No parking spot nearby'),
                          onTap: () {
                            setState(
                              () {
                                dropNumber = dropController.text;
                                InsertText().insertText(
                                    '\nDrop $dropNumber \nNo parking spot nearby',
                                    textController);
                              },
                            );
                          },
                        ),
                        color: Colors.teal[100],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Text('Customer\'s unit on level 2'),
                          onTap: () {
                            setState(
                              () {
                                dropNumber = dropController.text;
                                InsertText().insertText(
                                    '\nDrop $dropNumber \nCustomer\'s unit on level 2',
                                    textController);
                              },
                            );
                          },
                        ),
                        color: Colors.teal[100],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Text('Customer\'s unit on level 2'),
                          onTap: () {
                            setState(
                              () {
                                dropNumber = dropController.text;
                                InsertText().insertText(
                                    '\nDrop $dropNumber \nCustomer\'s unit on level 2',
                                    textController);
                              },
                            );
                          },
                        ),
                        color: Colors.teal[100],
                      ), */
                    ],
                  ),
                ) */
              ],
            ),
            // Result Tab
            NotesTab(
                textController, startDate, startTime, finishDate, finishTime),
          ]),
        ),
      ),
    );
  }
}
