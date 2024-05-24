import 'dart:convert';
import 'dart:io';

import 'package:api_handling/app_exceptions.dart';
import 'package:http/http.dart' as http;
class ApiHelper{
  getApi({required String apiUrl}) async {
    var uri = Uri.parse(apiUrl);
    try{
      var response = await http.get(Uri.parse(apiUrl));
      return returnJsonResponse(response);
    } on SocketException catch(e){
      throw FetchDataException(ErrorMsg: 'Network Error');
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

  dynamic returnJsonResponse(http.Response response){

    switch(response.statusCode){
      case 200 : {
        var mapData = jsonDecode(response.body);
        return mapData;
      }
      case 400 : {
        throw BadRequestException(ErrorMsg: response.body.toString());
      }
      case 403 : {
        throw UnAuthorisedException(ErrorMsg: response.body.toString());
      }
      default :
        throw FetchDataException(ErrorMsg: "error occured when communicate with server with satatus code ${response.statusCode}");
    }
  }
}