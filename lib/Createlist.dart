import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final List listMovies = [
    ['Harry Potter', 'David Yates'],
    ['Orignal Sin', 'Michael Cristofer'],
    ['The Noblemen', 'Vandana Kataria'],
  ];
  final myMovies = Set();
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: listMovies.length,
        itemBuilder: (context, item) {
          return _buildRow(listMovies[item]);
        });
  }

  Widget _buildRow(pair) {
    final alreadyWatched = myMovies.contains(pair);
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          pair[0],
          style: TextStyle(fontSize: 21.0),
        ),
        subtitle: Text(pair[1]),
        trailing: Icon(
          alreadyWatched ? Icons.check : Icons.play_circle_outline,
          color: alreadyWatched ? Colors.green[400] : null,
        ),
        onTap: () {
          setState(() {
            if (alreadyWatched) {
              myMovies.remove(pair);
            } else {
              myMovies.add(pair);
            }
          });
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = myMovies.map((pair) {
        return ListTile(
            title: Text(
              pair[0],
              style: TextStyle(fontSize: 21.0),
            ),
            subtitle: Text(pair[1]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  myMovies.remove(pair);
                });
              },
            ));
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('Watched Movies'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget build(BuildContext context) {
    final List<String> pair = [];
    String s1='';
    String s2='';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie-Game",
          style: TextStyle(fontSize: 30.0, fontFamily: 'Open Sans'),
        ),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add To Watched List'),
                  actions: <Widget>[
                    TextField(
                        onChanged: (value) {
                          s1 = value;
                        },
                        decoration: InputDecoration(hintText: 'Movie Name')),
                    TextField(
                        onChanged: (value) {
                          s2 = value;
                        },
                        decoration:
                            InputDecoration(hintText: 'Director\'s Name')),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            pair.add(s1);
                            pair.add(s2);
                            listMovies.add(pair);
                            Navigator.of(context).pop();
                          });
                        },
                        color: Colors.green[400],
                        child: Text('Ok')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.red[300],
                        child: Text('Cance'))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _buildList(),
    );
  }
}
