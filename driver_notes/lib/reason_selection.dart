import 'package:flutter/material.dart';

import 'insert_text.dart';
import 'options_list.dart';

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

  List<OptionsList> options = [
    OptionsList(0, false, 'No parking spot'),
    OptionsList(1, false, 'More Than 5 Totes'),
    OptionsList(2, false, 'label 3'),
    OptionsList(3, false, 'label 4'),
    OptionsList(4, false, 'label 5'),
    OptionsList(5, false, 'label 6'),
    OptionsList(5, false, 'label 7'),
    OptionsList(5, false, 'label 8'),
    OptionsList(5, false, 'label 9'),
  ];

  List<String> selectedItems = List<String>.filled(10, '', growable: true);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          width: 300,
          height: 300,
          child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              children: [
                ...options.map((value) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    //alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text(value.description),
                      onTap: () {
                        setState(() {
                          value.isSelected = !value.isSelected;
                          if (value.isSelected == true) {
                            selectedItems.insert(
                                value.index, value.description);
                          } else {
                            selectedItems.remove(value.description);
                          }
                          print(selectedItems);
                          // selectedItems.forEach((element) {
                          //   if (element.contains('')) {
                          //     selectedItems.insert(0, value.description);
                          //   }
                          // });
                        });
                      },
                    ),
                    color:
                        value.isSelected == true ? Colors.amber : Colors.white,
                  );
                }).toList(),
              ]),
        ),
      ),
      ElevatedButton(
        //onPressed: () => insertText('Drop \n', textController),
        //onPressed: () => showModalOptions(context),
        onPressed: () => {
          widget.textController.selection = TextSelection.collapsed(
              offset: widget.textController.text.length),
          InsertText().insertText(
              '\nDrop Number: ' + widget.dropsController.text + '\n',
              widget.textController),
          for (var i = 0; i < selectedItems.length; i++)
            {
              if (selectedItems[i].isNotEmpty)
                if (i == 0)
                  {
                    InsertText().insertText(
                        selectedItems[i] + ' + ', widget.textController),
                  }
                else if (i != selectedItems.length)
                  {
                    InsertText().insertText(
                        selectedItems[i] + ' ', widget.textController)
                  }
            },
          setState(() {
            for (var i = 0; i < options.length; i++) {
              options[i].isSelected = false;
              selectedItems[i] = '';
            }
          })
        },
        // Talvez colocar para adicionar item no TextField ao selecionar o item
        child: Text('Add Drop'),
      ),
    ]);

    /*GridView.builder(
      //physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          key: ValueKey(options[index].description),
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

          // The color depends on this is selected or not
          color:
              options[index].isSelected == true ? Colors.amber : Colors.white,
          child: Flex(direction: Axis.vertical, children: [
            ListTile(
              leading: Text(
                options[index].description.toString(),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // if this item isn't selected yet, "isSelected": false -> true
                // If this item already is selected: "isSelected": true -> false
                setState(() {
                  options[index].isSelected = !options[index].isSelected;
                  //selectedItems[index] = options[index].description;
                  selectedItems[index] = options[index].description;
                });
              },
            ),
          ]),
          /*title: Text(
          options[index].description, 
                      ),*/
        );
      },
    ); */
  }
}
