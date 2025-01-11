import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[
          //fungsi dropdown
          ListTile(
            title: DropdownButton(
                items: _priorities.map((String DropdownStringItem) {
                  return DropdownMenuItem<String>(
                    value: DropdownStringItem,
                    child: Text(DropdownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                  });
                }),
          ),

          //fungsi title
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: titleController,
              style: textStyle,
              onChanged: (value) {
                debugPrint('Somtehing Changed in title text field');
              },
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),

          //fungsi description
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: descriptionController,
              style: textStyle,
              onChanged: (value) {
                debugPrint('Somtehing Changed in description text field');
              },
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),

          //funsgi button
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, // Warna background tombol
                    foregroundColor: Colors.white, // Warna teks tombol
                    shadowColor: Colors.red, // Warna bayangan tombol
                    elevation: 5, // Ketinggian tombol
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      // Bentuk tombol
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18, // Ukuran teks
                      fontWeight: FontWeight.bold, // Tebal teks
                    ),
                  ),
                  onPressed: () {
                    debugPrint("Save Button Pressed!");
                  },
                )),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, // Warna background tombol
                    foregroundColor: Colors.white, // Warna teks tombol
                    shadowColor: Colors.red, // Warna bayangan tombol
                    elevation: 5, // Ketinggian tombol
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      // Bentuk tombol
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 18, // Ukuran teks
                      fontWeight: FontWeight.bold, // Tebal teks
                    ),
                  ),
                  onPressed: () {
                    debugPrint("Delete Button Pressed!");
                  },
                )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
