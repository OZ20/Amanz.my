
import 'package:amanzmy/model/post.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {

  final Post _post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }

  ArticlePage(this._post);

}