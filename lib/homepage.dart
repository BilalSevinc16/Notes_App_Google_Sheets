import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app_gsheets/button.dart';
import 'package:notes_app_gsheets/google_sheets_api.dart';
import 'package:notes_app_gsheets/loading_circle.dart';
import 'package:notes_app_gsheets/notes_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  void _post() {
    GoogleSheetsApi.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

  // wait for the data to be fetched from google sheets
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true) {
      startLoading();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "P O S T  A  N O T E",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: GoogleSheetsApi.loading == true
                    ? const LoadingCircle()
                    : const NotesGrid(),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "enter..",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("f l u t t e r"),
                    ),
                    MyButton(
                      text: "P O S T",
                      function: _post,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
