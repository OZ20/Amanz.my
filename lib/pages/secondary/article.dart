import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/model/category.dart';
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

  Widget header(TextTheme font, theme) {
    final Category _category = appBloc.getCategoryName(_post.categories);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                _category.name,
                style: font.title.copyWith(
                  background: Paint()
                    ..strokeWidth = 10.0
                    ..color = theme.brightness == Brightness.light
                        ? Colors.grey[350]
                        : Colors.grey[800],
                  color: theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
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
                  label: Text(DateFormat.MMMMd().format(_post.date) +
                      ' , ' +
                      DateFormat.jm().format(_post.date)))
            ],
          )
        ],
      ),
    );
  }

  Widget content(TextTheme font, ThemeData theme, context) {
    final textSize = 18.0;
    return Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: MarkdownBody(
            styleSheet: MarkdownStyleSheet(
              strong: font.body1
                  .copyWith(fontWeight: FontWeight.bold, fontSize: textSize),
              p: font.body1.copyWith(
                height: 1.3,
                letterSpacing: 1.0,
                fontSize: textSize,
              ),
              a: font.body1.copyWith(
                  decoration: TextDecoration.underline,
                  letterSpacing: 1.0,
                  fontSize: textSize,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  shadows: <Shadow>[
                    Shadow(
                        blurRadius: 5.0,
                        color: theme.brightness == Brightness.light
                            ? Colors.blue
                            : Colors.blue),
                  ]),
              em: font.body1,
              h1: font.title,
              h2: font.title,
              h3: font.title,
              h4: font.title,
              h5: font.title,
              h6: font.title,
              blockquotePadding: 15.0,
              blockquoteDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: theme.brightness == Brightness.light
                    ? Colors.grey[200]
                    : Colors.grey[800],
              ),
              blockSpacing: 25.0,
              img: TextStyle(),
            ),
            data: html2md.convert(_post.content['rendered']),
            onTapLink: (data) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebviewScaffold(
                        appBar: AppBar(),
                        initialChild: Container(
                            color: Colors.grey,
                            child: const Center(
                                child: CircularProgressIndicator())),
                        appCacheEnabled: true,
                        url: data))),
          ),
        ),
      );
  }

  ArticlePage(this._post);
}
