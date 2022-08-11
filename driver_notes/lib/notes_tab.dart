import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'insert_text.dart';

class NotesTab extends StatefulWidget {
  final TextEditingController _notesText;
  final TextEditingController startDate;
  final TextEditingController startTime;
  final TextEditingController finishDate;
  final TextEditingController finishTime;

  NotesTab(this._notesText, this.startDate, this.startTime, this.finishDate,
      this.finishTime);

  TextEditingController getNotesText() {
    return _notesText;
  }

  @override
  _NotesTabState createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  void copyData() {
    String result = 'Starting Date: ' +
        widget.startDate.text +
        ' - Time: ' +
        widget.startTime.text +
        '\nFinishing Date: ' +
        widget.finishDate.text +
        ' - Time: ' +
        widget.finishTime.text +
        '\n' +
        widget._notesText.text +
        '\n';

    //Check possibility to chage conditionals to use switch case instead

    if (refueledTruck == true) {
      result += '\n• Refueled Truck';
    }

    if (returnedTotes == true) {
      result += '\n• Totes retured at Docks';
    }
    if (queueTotes == true) {
      result += '\n• Queue to return totes at Docks';
    }

    print(result);
    Clipboard.setData(
      ClipboardData(text: result),
    );
  }

  bool refueledTruck = false;
  bool returnedTotes = false;
  bool queueTotes = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black87),
              borderRadius: BorderRadius.circular(15),
            )),
            minLines: 10,
            onTap: () {
              //Prevent issue when remove the text in the field manually.
              widget._notesText.selection = TextSelection.collapsed(
                  offset: widget._notesText.text.length);
            },
            maxLines: 10,
            controller: widget._notesText,
            onSubmitted: (_) => InsertText()
                .insertText(widget._notesText.text, widget._notesText),
          ),
          IconButton(onPressed: copyData, icon: Icon(Icons.copy)),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.05),
            child: CheckboxListTile(
                activeColor: Colors.green.shade900,
                value: refueledTruck,
                onChanged: (bool? newValue) {
                  setState(() {
                    refueledTruck = newValue!;
                  });
                },
                title: Text('Refueled Truck')),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.05),
            child: CheckboxListTile(
                activeColor: Colors.green.shade900,
                value: returnedTotes,
                onChanged: (bool? newValue) {
                  setState(() {
                    returnedTotes = newValue!;
                  });
                },
                title: Text('Returned Totes')),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.05),
            child: CheckboxListTile(
                activeColor: Colors.green.shade900,
                value: queueTotes,
                onChanged: (bool? newValue) {
                  setState(() {
                    queueTotes = newValue!;
                  });
                },
                title: Text('Queue to return totes')),
          ),
        ],
      ),
    );
  }
}
