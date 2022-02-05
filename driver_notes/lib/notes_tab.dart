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
    String result = '';
    result = 'Starting Date: ' +
        widget.startDate.text +
        ' - Time: ' +
        widget.startTime.text +
        '\nFinishing Date: ' +
        widget.finishDate.text +
        ' - Time: ' +
        widget.finishTime.text +
        '\n' +
        widget._notesText.text;

    print(result);
    Clipboard.setData(
      ClipboardData(text: result),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            )),
            minLines: 10,
            maxLines: 10,
            controller: widget._notesText,
            onSubmitted: (_) => InsertText()
                .insertText(widget._notesText.text, widget._notesText),
          ),
          IconButton(onPressed: copyData, icon: Icon(Icons.copy)),
        ],
      ),
    );
  }
}
