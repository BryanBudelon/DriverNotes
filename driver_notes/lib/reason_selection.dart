import 'package:flutter/material.dart';

class ReasonSelection extends StatefulWidget {
  const ReasonSelection({Key? key}) : super(key: key);

  @override
  _ReasonSelectionState createState() => _ReasonSelectionState();
}

class _ReasonSelectionState extends State<ReasonSelection> {
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // ontap of each card, set the defined int to the grid view index
                selectedCard = index;
              });
            },
            child: Card(
              // check if the index is equal to the selected Card integer
              color: selectedCard == index ? Colors.blue : Colors.amber,
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
