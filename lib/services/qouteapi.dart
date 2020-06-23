import 'package:http/http.dart' as http;
import 'package:qouteapp/models/qouteData.dart';

class Services {
  static const String url = 'https://qoute.arpitsharma.tech/';
  static Future<List<Qoute>> getdata() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Qoute> qouteLlist = qouteFromJson(response.body);
        return qouteLlist;
      } else {
        return List<Qoute>();
      }
    } catch (e) {
      return List<Qoute>();
    }
  }
}
