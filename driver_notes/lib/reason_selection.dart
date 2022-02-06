import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'options_list.dart';

class ReasonSelection extends StatefulWidget {
  const ReasonSelection({Key? key}) : super(key: key);

  @override
  _ReasonSelectionState createState() => _ReasonSelectionState();
}

class _ReasonSelectionState extends State<ReasonSelection> {
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

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: options.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              key: ValueKey(options[index].description),
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              // The color depends on this is selected or not
              color: options[index].isSelected == true
                  ? Colors.amber
                  : Colors.white,
              child: ListTile(
                onTap: () {
                  // if this item isn't selected yet, "isSelected": false -> true
                  // If this item already is selected: "isSelected": true -> false
                  setState(() {
                    options[index].isSelected = !options[index].isSelected;
                  });
                },
                leading: Text(
                  options[index].description.toString(),
                  textAlign: TextAlign.center,
                ),
                /*title: Text(
                  options[index].description, 
                ),*/
              ));
        },

        /*GestureDetector(
              onTap: () {
                setState(() {
                  // ontap of each card, set the defined int to the grid view index
                  selectedCard = index;
                });
              },
              onLongPress: () {},
              child: Card(
                // check if the index is equal to the selected Card integer
                color: selectedCard == index ? Colors.blue : Colors.amber,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Text(
                      reasons[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ); */
      ),
    );
  }
}
