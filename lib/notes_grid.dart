import 'package:flutter/material.dart';
import 'package:notes_app_gsheets/google_sheets_api.dart';
import 'package:notes_app_gsheets/textbox.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GoogleSheetsApi.currentNotes.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return MyTextBox(text: GoogleSheetsApi.currentNotes[index]);
      },
    );
  }
}
