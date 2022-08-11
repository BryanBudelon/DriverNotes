// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:driver_notes/notes_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'insert_text.dart';
import 'reason_selection.dart';

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
  final startDate = TextEditingController();
  final startTime = TextEditingController();
  final finishDate = TextEditingController();
  final finishTime = TextEditingController();
  final textController = TextEditingController();
  final dropController = TextEditingController();

  String dropNumber = '';

  @override
  void dispose() {
    //Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    startDate.dispose();
    super.dispose();
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
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('EzNotes'),
                backgroundColor: Colors.green.shade900,
                bottom: TabBar(
                  tabs: [
                    Icon(Icons.fact_check),
                    Icon(Icons.done),
                  ],
                ),
              ),
              body: TabBarView(children: [
                // Action Tab
                Container(
                  //padding:EdgeInsets.all(MediaQuery.of(context).size.height / 0),
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          padding: EdgeInsets.only(left: 50.0),
                          child: SizedBox(
                            width: 120,
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Starting Date'),
                              controller: startDate,
                              onTap: _startDatePicker,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: 'Starting Time'),
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
                              decoration:
                                  InputDecoration(labelText: 'Finising Date'),
                              controller: finishDate,
                              onTap: _finishDatePicker,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: 'Finising Time'),
                            controller: finishTime,
                            onTap: _finishTimePicker,
                          ),
                        ),
                      ]),
                      Container(
                        width: 350,
                        padding: EdgeInsets.only(left: 50.0),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.15),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Drop Number',
                              suffixIcon: Container(
                                padding: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Row(children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                    onPressed: () {
                                      if (dropController.text.isEmpty) {
                                        dropController.text = '1';
                                      } else {
                                        var value =
                                            int.parse(dropController.text);
                                        dropController.text =
                                            (value + 1).toString();
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      var value =
                                          int.parse(dropController.text);
                                      if (value > 0) {
                                        dropController.text =
                                            (value - 1).toString();
                                        FocusScope.of(context).unfocus();
                                      }
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
                            padding: EdgeInsets.all(5),
                            child: ReasonSelection(
                                textController, dropController)),
                      ),
                    ],
                  ),
                ),

                // Result Tab
                NotesTab(textController, startDate, startTime, finishDate,
                    finishTime),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
