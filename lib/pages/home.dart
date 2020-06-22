import 'package:flutter/material.dart';
import 'package:qouteapp/models/qouteData.dart';
import 'package:qouteapp/services/qouteapi.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Qoute> _users;
  bool _loading = true;
  void setupQouteApi() async {
    await Services.getdata().then((data) {
      setState(() {
        _users = data;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Users'),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.green[500],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.grey,
              // height: 20,
              thickness: 2,
              // indent: 20,
              endIndent: 0,
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.grey,
              // height: 20,
              thickness: 2,
              // indent: 20,
              endIndent: 0,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _users ? 0 : _users.length,
          itemBuilder: (context, index) {
            QouteElement user = _users[0].qoute[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(user.completed ? Icons.done : Icons.close),
                      title: Text(user.title),
                      subtitle: Text('Here is a second line'),
                      onTap: () {
                        print(index);
                      },
                    ),
                  ],
                ),
              ),
            );

            //   ListTile(
            //   leading: Icon(user.completed ? Icons.done : Icons.close),
            //   title: Text(user.title),
            //   subtitle: Text('Here is a second line'),
            //   onTap: () {
            //     print(index);
            //   },
            // );
          },
        ),
      ),
    );
  }
}
