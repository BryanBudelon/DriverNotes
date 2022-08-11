import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'insert_text.dart';
import '../models/options_list.dart';

class ReasonSelection extends StatefulWidget {
  final TextEditingController textController;
  final TextEditingController dropsController;

  ReasonSelection(this.textController, this.dropsController);

  @override
  ReasonSelectionState createState() => ReasonSelectionState();
}

class ReasonSelectionState extends State<ReasonSelection> {
  int selectedCard = -1;
  int _selectedIndex = -1;

  TextEditingController totesQtd = TextEditingController();

  List<OptionsList> options = [
    OptionsList(0, false, 'No parking spot'),
    OptionsList(1, false, 'More Than 5 Totes'),
    OptionsList(2, false, 'Customer\'s Unit on Level'),
    OptionsList(3, false, 'Many Stairs'),
    OptionsList(4, false, 'Poor Instructions'),
    OptionsList(5, false, 'Customer not home. Called C. Service.'),
    OptionsList(6, false, 'Parked truck ... away'),
    OptionsList(7, false, 'Challenging weather'),
    OptionsList(8, false, 'Slippery Ramp'),
    OptionsList(9, false, 'Long Driveway'),
  ];

  List<String> selectedItems = [];

  var numberQtdTotes = List.generate(100, (index) => index);

  void _showToteQuantity(BuildContext ctx, int position) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Card(
              child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'How many totes?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 100,
                        child: CupertinoPicker(
                            itemExtent: 20,
                            onSelectedItemChanged: (value) {},
                            children: [
                              for (var i in numberQtdTotes) Text(i.toString())
                            ]),
                      )
                      /*TextField(
                        controller: totesQtd,
                        keyboardType: TextInputType.number,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          selectedItems.add(totesQtd.text + ' Totes');
                          Navigator.of(context).pop();
                        },
                        child: Container(child: Text('Save')),
                      ) */
                    ],
                  ),
                  height: 200)),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 7.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            child: GridView.count(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                children: [
                  ...options.map((value) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        child: Center(
                          child: Text(
                            value.description,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            value.isSelected = !value.isSelected;
                            if (value.isSelected == true) {
                              if (value.index == 1) {
                                _showToteQuantity(context, value.index);
                              } else {
                                selectedItems.add(value.description);
                              }
                            } else {
                              selectedItems.remove(value.description);
                            }
                            print(selectedItems);
                          });
                        },
                      ),
                      color: value.isSelected == true
                          ? Colors.amber
                          : Colors.white,
                    );
                  }).toList(),
                ]),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade900)),
          onPressed: () => {
            //Get the cursor position
            widget.textController.selection = TextSelection.collapsed(
                offset: widget.textController.text.length),

            //Add Drop Number
            InsertText().insertText(
                '\n\nDrop Number: ' + widget.dropsController.text + '\n',
                widget.textController),

            //Check and write all selected items
            for (var i = 0; i < selectedItems.length; i++)
              {
                InsertText().insertText(
                    '\n\t• ' + selectedItems[i] + '', widget.textController)
              },
            //Set to false selected items and the list with selected items.
            setState(() {
              for (var i = 0; i < options.length; i++) {
                options[i].isSelected = false;
              }
              selectedItems.removeRange(0, selectedItems.length);
            })
          },
          child: Text('Add Drop'),
        ),
      ],
    );
  }
}
