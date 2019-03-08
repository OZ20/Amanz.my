import 'package:amanzmy/blocs/article.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/pages/secondary/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final font = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final cardHeight = 250.0;
    return Container(
      height: cardHeight,
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider<ArticlePageBloc>(
                  bloc: ArticlePageBloc(),
                  child: ArticlePage(_post),
                ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 2.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Hero(
                  tag: _post.id,
                  child: CachedNetworkImage(
                      width: size.width,
                      height: cardHeight,
                      fit: BoxFit.cover,
                      imageUrl: _post.jpFeaturedMedia),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: theme.brightness == Brightness.light
                          ? LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                                  Color(0xFF4286f4).withOpacity(.3),
                                  Color(0xFF373B44).withOpacity(.8),
                                ])
                          : LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                                  Color(0xFFbdc3c7).withOpacity(.5),
                                  Color(0xFF2c3e50).withOpacity(.8),
                                ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: '${_post.id}: tajuk',
                        child: Text(
                          HtmlUnescape().convert(_post.title['rendered']),
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: font.title.copyWith(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                          DateFormat.MMMMd().format(_post.date) +
                              ' , ' +
                              DateFormat.jm().format(_post.date),
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                          )),
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
