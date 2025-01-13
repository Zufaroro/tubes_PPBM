import 'package:flutter/material.dart';

class NewVideoScreen extends StatefulWidget {
  @override
  _NewVideoScreenState createState() => _NewVideoScreenState();
}

class _NewVideoScreenState extends State<NewVideoScreen> {
  final _urlController = TextEditingController();
  final _fileNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Video"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: "YouTube URL",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _fileNameController,
              decoration: InputDecoration(
                labelText: "File Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "url": _urlController.text,
                  "fileName": _fileNameController.text,
                  "description": _descriptionController.text,
                });
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
