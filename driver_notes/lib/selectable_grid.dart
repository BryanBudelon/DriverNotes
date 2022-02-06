import 'package:flutter/material.dart';

import 'month_option.dart';

class SelectableGrid extends StatefulWidget {
  const SelectableGrid({Key? key}) : super(key: key);

  @override
  _SelectableGridState createState() => _SelectableGridState();
}

class _SelectableGridState extends State<SelectableGrid> {
  static const List<Map<String, dynamic>> months = <Map<String, dynamic>>[
    <String, dynamic>{
      'month': 'January',
      'img': 'assets/images/Jan.jpg',
    },
    <String, dynamic>{
      'month': 'February',
      'img': 'assets/images/Feb.jpg',
    },
    <String, dynamic>{
      'month': 'March',
      'img': 'assets/images/Mar.jpg',
    },
  ];

  int optionSelected = 0;

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection and Settings $optionSelected'),
      ),
      body: Container(
        width: 300,
        child: GridView.count(crossAxisCount: 2, children: <Widget>[
          /*for (int i = 0; i < months.length; i++)
              MonthOption(
                months[i]['month'] as String,
                img: months[i]['img'] as String,
                onTap: () => checkOption(i + 1),
                selected: i + 1 == optionSelected,
                key: null,
              )
          ], */
        ]),
      ),
    );
  }
}
