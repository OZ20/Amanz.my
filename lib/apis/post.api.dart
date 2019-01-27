import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://amanz.my/wp-json/wp/v2';

Future getAllPost() async {
 try {
   var response = await http.get(baseUrl + '');
   if(response.statusCode == 200){
     return jsonDecode(response.body);
   }
 } on Exception catch (e) {
   throw e;
 }

}