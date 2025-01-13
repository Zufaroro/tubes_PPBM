import 'package:flutter/material.dart';

class AddVideoPage extends StatefulWidget {
  final Function(Map<String, String>) onAddVideo;

  const AddVideoPage({super.key, required this.onAddVideo});

  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Video Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            TextField(
              controller: _thumbnailController,
              decoration: const InputDecoration(labelText: 'Thumbnail URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newVideo = {
                  'title': _titleController.text,
                  'url': _urlController.text,
                  'thumbnail': _thumbnailController.text,
                };
                widget.onAddVideo(newVideo);
                Navigator.pop(context);
              },
              child: const Text('Add Video'),
            ),
          ],
        ),
      ),
    );
  }
}