import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/pages/article.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatelessWidget {
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardHeight = 250.0;
    return Container(
      height: cardHeight,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ArticlePage(_post))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Card(
            elevation: 2.0,
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                    errorWidget: Container(color: Colors.grey,),
                    width: size.width,
                    height: cardHeight,
                    fit: BoxFit.cover,
                    imageUrl: _post.jpFeaturedMedia),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_post.title['rendered']),
                    Text(_post.date.toLocal().toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PostCard(this._post);
}
