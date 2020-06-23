import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qouteapp/models/qouteData.dart';
import 'package:qouteapp/services/qouteapi.dart';

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<Qoute> _data;
  bool load = true;
  GlobalKey<RefreshIndicatorState> refreshKey;
  void setupQouteApi() async {
    await Services.getdata().then((data) {
      refreshKey = GlobalKey<RefreshIndicatorState>();
      setState(() {
        _data = data;
      });
    });
    Navigator.pushReplacementNamed(context, '/home',
        arguments: {'uuid': _data[0].uuid, 'qoute': _data, 'key': refreshKey});
  }
  // void setupWorldTime() async {
  //   WorldTime instance = WorldTime(
  //       location: 'Kolkata', flag: 'germany.png', url: 'Asia/Kolkata');
  //   await instance.getTime();
  //   Navigator.pushReplacementNamed(context, '/home', arguments: {
  //     'location': instance.location,
  //     'flag': instance.flag,
  //     'time': instance.time,
  //     'isDayTime': instance.isDayTime
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setupQouteApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCubeGrid(
        color: Colors.green[400],
        size: 80.0,
      ),
    ));
  }
}
