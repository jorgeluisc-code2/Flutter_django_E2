import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    String url = 'http://192.168.1.3:8000/institutos/?search=$query';
    
    http.Response response = await http.get(Uri.encodeFull(url));

    return response.body;
  }
}

class SearchServiceRuc {
  static Future<String> searchDjangoApi2(String query) async {
    String url = 'http://192.168.1.3:8000/institutosruc/?search=$query';
    
    http.Response response = await http.get(Uri.encodeFull(url));

    return response.body;
  }
}
