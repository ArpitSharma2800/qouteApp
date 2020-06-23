import 'package:flutter/material.dart';
import 'package:qouteapp/models/qouteData.dart';
import 'package:qouteapp/services/qouteapi.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<QouteElement> _users;
  List<Qoute> _data;
  bool _loading = true;

  Future<Null> onrefresh() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/');
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    setState(() {
      _loading = false;
      _users = data['qoute'][0].qoute;
      refreshKey = data['key'];
    });

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Sorry for inconvenience"),
            content: new Text("Our team is working on fixing this issue!"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading ? 'Loading...' : 'Qoutes',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        label: const Text(
          'Add Qoute',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          _showDialog();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        // notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.stay_current_landscape,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        // key: refreshKey,
        color: Colors.green[500],
        strokeWidth: 2.0,
        displacement: 100.0,
        onRefresh: () async {
          await onrefresh();
        },
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: null == _users ? 0 : _users.length,
            itemBuilder: (context, index) {
              String user = _users[index].title;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 2.0, color: Colors.green))),
                        child: Icon(Icons.format_quote, color: Colors.green),
                      ),
                      title: Text(
                        user,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.content_copy,
                          color: Colors.green, size: 30.0),
                      onTap: () {
                        ClipboardManager.copyToClipBoard(user).then((result) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
