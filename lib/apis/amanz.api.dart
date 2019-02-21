import 'dart:async';
import 'dart:convert';

import 'package:amanzmy/util/strings.dart';
import 'package:http/http.dart' as http;


Future getPost({String uri = baseUrl , String addUri = '', int offset = 0 , int count = 20}) async {
  try {
    var response = await http.get(uri + '/posts?$addUri&_embed&per_page=$count&offset=$offset');
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  } on Exception catch (e) {
    throw e;
  }
}

Future getCategories() async {
  try {
    var response = await http.get(baseUrl + categoriesUrl + '?per_page=100');
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  } on Exception catch (e) {
    throw e;
  }
}