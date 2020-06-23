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

  List<QouteElement> _users;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    setState(() {
      _loading = false;
      _users = data['qoute'][0].qoute;
    });

    makeListTile(String lesson) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    top: new BorderSide(width: 2.0, color: Colors.green),
                    right: new BorderSide(width: 2.0, color: Colors.green))),
            child: Icon(Icons.format_quote, color: Colors.green),
          ),
          title: Text(
            lesson,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.content_copy, color: Colors.green, size: 30.0),
          onTap: () {
            final scaffold = Scaffold.of(context);
            scaffold.showSnackBar(
              SnackBar(
                content: const Text('Updating..'),
              ),
            );
          },
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading ? 'Loading...' : 'Qoutes',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
