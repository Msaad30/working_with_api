import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiHelper{
  getApi({required String apiUrl}) async {
    var response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      var mapData = jsonDecode(response.body);
      return mapData;
    } else {
      return null;
    }
  }

  postApi({required String apiUrl, Map<String, dynamic>? bodyParams}) async {
    var response = await http.post(Uri.parse(apiUrl),body: bodyParams ?? {});
    if(response.statusCode == 200){
      var mapData = jsonDecode(response.body);
      return mapData;
    } else {
      return null;
    }
  }
}