import 'dart:async';
import 'dart:convert';

import 'package:amanzmy/util/strings.dart';
import 'package:http/http.dart' as http;


Future getPost({int offset = 0 , int count = 10, String addUri = ''}) async {
  try {
    var response = await http.get(baseUrl + addUri + '/posts?per_page=$count&offset=$offset');
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  } on Exception catch (e) {
    throw e;
  }
}