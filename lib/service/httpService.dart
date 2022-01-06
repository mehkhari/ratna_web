import 'dart:developer';

import 'package:http/http.dart' as http;

class Api{
  static const String baseUrl="https://rathna3121.pythonanywhere.com/";
  
  Future<String?> getSteps()async{
    log("Getting Steps Data");
    var response=await http.get(Uri.parse("${baseUrl}video_list/"));
    log("Response from http Get--->${response.body}");
    if(response.statusCode==200){
      return response.body;
    }else{
      return null;
    }
  }
}