import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final List listMovies = [
    [
      'Harry Potter',
      'David Yates',
      '0',
      'https://mypostercollection.com/wp-content/uploads/2018/09/Harry-Potter-Poster-2001-MyPosterCollection.com-1.jpg'
    ],
    [
      'Orignal Sin',
      'Michael Cristofer',
      '0',
      'https://mypostercollection.com/wp-content/uploads/2018/09/Harry-Potter-Poster-2001-MyPosterCollection.com-1.jpg'
    ],
    [
      'The Noblemen',
      'Vandana Kataria',
      '0',
      'https://mypostercollection.com/wp-content/uploads/2018/09/Harry-Potter-Poster-2001-MyPosterCollection.com-1.jpg'
    ],
    [
      'abcd',
      '123',
      '0',
      'https://mypostercollection.com/wp-content/uploads/2018/09/Harry-Potter-Poster-2001-MyPosterCollection.com-1.jpg'
    ]
  ];
  final myMovies = Set();
  void updatemyList(var list) {
    list.forEach((element) {
      if (element[2] == '1') {
        setState(() {
          myMovies.add(element);
        });

        print('updated');
      } else if (element[2] == '0') {
        myMovies.remove(element);
      }
    });
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: listMovies.length,
        itemBuilder: (context, item) {
          return _buildRow(listMovies[item]);
        });
  }

  Widget _buildRow(item) {
    final alreadyWatched = myMovies.contains(item);
    String s1 = item[0];
    String s2 = item[1];
    String s3 = item[3];
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
          title: Text(
            item[0],
            style: TextStyle(fontSize: 21.0),
          ),
          subtitle: Text(item[1]),
          trailing: IconButton(
              onPressed: () => {
                    setState(() {
                      if (alreadyWatched) {
                        int index = listMovies.indexOf(item);
                        setState(() {
                          listMovies[index][2] = '0';
                          print(listMovies[index]);
                          updatemyList(listMovies);
                        });
                        myMovies.remove(item);
                      } else {
                        int index = listMovies.indexOf(item);
                        print(listMovies[index]);
                        //print(x);
                        setState(() {
                          listMovies[index][2] = '1';
                          print(listMovies[index]);
                          updatemyList(listMovies);
                        });
                      }
                    })
                  },
              icon: Icon(
                alreadyWatched ? Icons.check : Icons.play_circle_outline,
                color: alreadyWatched ? Colors.green[400] : null,
              )),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Movie : $s1'),
                    actions: <Widget>[
                      TextField(
                          onChanged: (value) {
                            if(value!='')
                            {s1 = value;}
                          },
                          decoration: InputDecoration(hintText: 'Movie Name')),
                      TextField(
                          onChanged: (value) {
                            if(value!='')
                            {s2 = value;}
                          },
                          decoration:
                              InputDecoration(hintText: 'Director\'s Name')),
                      TextField(
                          onChanged: (value) {
                            if(value!='')
                            {
                                s3 = value;
                            }
                            
                          },
                          decoration: InputDecoration(
                              hintText:
                                  'Poster URL(Note: The url should return .jpg file)')),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              int index = listMovies.indexOf(item);
                              listMovies[index][0] = s1;
                              listMovies[index][1] = s2;
                              listMovies[index][3] = s3;
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
          leading: SizedBox(
              height: 100.0,
              width: 100.0, // fixed width and height
              child: Image.network(item[3]))),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = myMovies.map((element) {
        return ListTile(
            title: Text(
              element[0],
              style: TextStyle(fontSize: 21.0),
            ),
            subtitle: Text(element[1]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  int index = listMovies.indexOf(element);
                  listMovies[index][2] = '0';
                  updatemyList(listMovies);
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
    final List pair = [];
    String s1 = '';
    String s2 = '';
    String s3 = '';
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
                    TextField(
                        onChanged: (value) {
                          s3 = value;
                        },
                        decoration: InputDecoration(
                            hintText:
                                'Poster URL(Note: The url should return .jpg file)')),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            pair.add(s1);
                            pair.add(s2);
                            pair.add('0');
                            pair.add(s3);
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
