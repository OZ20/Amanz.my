import 'dart:async';
import 'dart:convert';

import 'package:amanzmy/util/strings.dart';
import 'package:http/http.dart' as http;


Future getAllPost() async {
 try {
   var response = await http.get(baseUrl + '/posts?per_page=10');
   if(response.statusCode == 200){
     return jsonDecode(response.body);
   }
 } on Exception catch (e) {
   throw e;
 }

}