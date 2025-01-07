import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB is Presed');
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.headlineSmall!;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.amber[50],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red[400],
              child: Icon(Icons.account_circle_outlined),
            ),
            title: Text(
              'ikhwan',
              style: titleStyle,
            ),
            subtitle: Text('27 septermber 2024'),
            trailing: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint('List Tile Is Tapped');
            },
          ),
        );
      },
    );
  }
}
