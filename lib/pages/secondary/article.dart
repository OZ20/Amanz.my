import 'package:amanzmy/model/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatelessWidget {
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final font = theme.textTheme;
    final appBarSpaceHeight = 250.0;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, index) => <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: appBarSpaceHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: _post.jpFeaturedMedia == null
                      ? Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.white],
                                  begin: Alignment.centerLeft,
                                  tileMode: TileMode.mirror)),
                        )
                      : Stack(
                          children: <Widget>[
                            Container(
                              height: 300.0,
                              child: CachedNetworkImage(
                                  errorWidget: Container(
                                    color: Colors.grey,
                                  ),
                                  width: size.width,
                                  fit: BoxFit.cover,
                                  imageUrl: _post.jpFeaturedMedia),
                            ),
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
                          ],
                        ),
                ),
              ),
            ],
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              header(font, theme),
              SizedBox(
                height: 30.0,
              ),
              content(font, theme, context),
              SizedBox(
                height: 100.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header(font, theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  HtmlUnescape().convert(_post.title['rendered']),
                  textAlign: TextAlign.center,
                  style: font.title.copyWith(
                    fontSize: 20.0,
                    background: Paint()
                      ..color = theme.brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    color: theme.brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Chip(
                    label:
                        Text(DateFormat.MMMMd().format(_post.date) + ' , ' + DateFormat.jm().format(_post.date))
                )
              ],
            )
          ],
        ),
      );

  Widget content(font, theme, context) => Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: MarkdownBody(
            styleSheet: MarkdownStyleSheet(
              p: font.body1.copyWith(
                fontSize: 20.0,
              ),
              a: font.body1.copyWith(
                  decoration: TextDecoration.underline,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  shadows: <Shadow>[
                    Shadow(
                        blurRadius: 5.0,
                        color: theme.brightness == Brightness.light
                            ? Colors.blue
                            : Colors.blue),
                  ]),
              blockSpacing: 35.0,
              img: TextStyle(),
            ),
            data: html2md.convert(_post.content['rendered']),
            onTapLink: (data) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebviewScaffold(url: data))),
          ),
        ),
      );

  ArticlePage(this._post);
}
