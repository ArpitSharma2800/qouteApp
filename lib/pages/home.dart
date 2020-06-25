import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qouteapp/models/qouteData.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:http/http.dart' as http;
import 'package:qouteapp/models/postResponse.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<QouteElement> _users;
  bool _loading = true;
  bool _update = false;
  final TextEditingController quoteController = TextEditingController();
  Future<Null> onrefresh() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/');
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  String apiUrlLogin = "https://qoute.arpitsharma.tech/add";
  Future<Postresponse> login(String quote) async {
    Map map = {
      'uuid': 'arpit',
      'qoute': [
        {'title': quote}
      ]
    };
    String body = json.encode(map);
    try {
      var response = await http.post(
        Uri.encodeFull(apiUrlLogin),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (200 == response.statusCode) {
        onrefresh();
        return (null);
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var screenSize = MediaQuery.of(context).size;
          return (_update == false
              ? AlertDialog(
                  title: new Text("Add your quote!!"),
                  content: Container(
                    height: screenSize.height / 6,
                    width: screenSize.width - 50.0,
                    padding: EdgeInsets.fromLTRB(00.0, 10.0, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: quoteController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              hintText: "Qoute",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          "Page wll automatically refresh after 2 seconds!!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Submit"),
                      onPressed: () {
                        final String quote = quoteController.text;
                        if (quote.isNotEmpty) {
                          login(quote);
                          Navigator.of(context).pop();
                          setState(() {
                            _update = true;
                          });
                        }
                      },
                    ),
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              : Center(
                  child: SpinKitCubeGrid(
                    color: Colors.green[400],
                    size: 80.0,
                  ),
                ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading ? 'Loading...' : 'Quotes',
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
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                        final snackBar = SnackBar(
                          content: Text('Copied to Clipboard'),
                          action: SnackBarAction(
                            label: 'Okey',
                            onPressed: () {},
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        FlutterClipboardManager.copyToClipBoard(user)
                            .then((result) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Okey',
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
