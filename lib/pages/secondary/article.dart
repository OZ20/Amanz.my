import 'package:amanzmy/model/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  WebViewController _controller;
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final font = theme.textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(HtmlUnescape().convert(_post.title['rendered']),style: font.title.copyWith(fontSize: 20.0),),
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
                        CachedNetworkImage(
                            errorWidget: Container(
                              color: Colors.grey,
                            ),
                            width: size.width,
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
                      ],
                    ),
            ),
          ),
          new SliverFillRemaining(
            child: Container(
              color: theme.backgroundColor,
              child: WebView(
                initialUrl: 'wwww.google.com',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) => _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ArticlePage(this._post);
}
