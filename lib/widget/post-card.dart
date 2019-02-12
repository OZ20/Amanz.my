import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/pages/secondary/article.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';


class PostCard extends StatelessWidget {
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final locale = Locale.fromSubtags(countryCode: 'US');
    final theme = Theme.of(context);
    final font = theme.textTheme;
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
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 2.0,
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                    errorWidget: Container(
                      color: Colors.grey,
                    ),
                    width: size.width,
                    height: cardHeight,
                    fit: BoxFit.cover,
                    imageUrl: _post.jpFeaturedMedia),
                Container(
                  decoration: BoxDecoration(
                      gradient: theme.brightness == Brightness.light
                          ? LinearGradient(colors: [
                              Color(0xFF373B44).withOpacity(.8),
                              Color(0xFF4286f4).withOpacity(.7),
                            ])
                          : LinearGradient(colors: [
                              Color(0xFFbdc3c7).withOpacity(.8),
                              Color(0xFF2c3e50).withOpacity(.9),
                            ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0, bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        HtmlUnescape().convert(_post.title['rendered']),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: font.title.copyWith(fontSize: 17, color: Colors.white,),
                      ),
                      Text(_post.date.toLocal().toString(),
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.white, locale: locale)),
                    ],
                  ),
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
