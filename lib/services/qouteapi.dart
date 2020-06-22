import 'package:http/http.dart' as http;
import 'package:qouteapp/models/qouteData.dart';

class Services {
  static const String url = 'https://qoute.arpitsharma.tech/';
  static Future<List<Qoute>> getdata() async {
    final response = await http.get(url);
    try {
      final List<Qoute> todotlist = qouteFromJson(response.body);
      return todotlist;
    } catch (e) {
      return List<Qoute>();
    }
  }
}
