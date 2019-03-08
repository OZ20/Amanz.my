import 'package:amanzmy/blocs/article.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/pages/secondary/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class SearchCard extends StatelessWidget {
  final Post _post;

  SearchCard(this._post);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<ArticlePageBloc>(
                  child: ArticlePage(_post),
                  bloc: ArticlePageBloc(),
                ),
          )),
      child: Container(
        width: size.width,
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: size.width * (2 / 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(HtmlUnescape().convert(_post.title['rendered'])),
                        Container(
                          height: 40.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _post.embedded.wpTerm.category.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Chip(
                                      label: Text(_post.embedded.wpTerm
                                          .category[index].name)),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Hero(
                  tag: _post.id,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: _post.embedded.media != null
                        ? CachedNetworkImage(
                            height: 80.0,
                            width: 80.0,
                            placeholder: CircularProgressIndicator(),
                            imageUrl: _post
                                .embedded.media[0].media.thumbnail.sourceUrl)
                        : Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                gradient: theme.brightness == Brightness.light
                                    ? LinearGradient(colors: [
                                        Color(0xFF373B44).withOpacity(.5),
                                        Color(0xFF4286f4).withOpacity(.4),
                                      ])
                                    : LinearGradient(colors: [
                                        Color(0xFFbdc3c7).withOpacity(.5),
                                        Color(0xFF2c3e50).withOpacity(.6),
                                      ])),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
