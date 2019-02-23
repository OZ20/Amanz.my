import 'package:amanzmy/blocs/article.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticlePage extends StatelessWidget {
  final Post _post;

  @override
  Widget build(BuildContext context) {
    final ArticlePageBloc _bloc = BlocProvider.of<ArticlePageBloc>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final font = theme.textTheme;
    final appBarSpaceHeight = 250.0;
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext sliverContext, index) => <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: appBarSpaceHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: _post.id,
                    child: Stack(
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
                                      Color(0xFF373B44).withOpacity(.5),
                                      Color(0xFF4286f4).withOpacity(.4),
                                    ])
                                  : LinearGradient(colors: [
                                      Color(0xFFbdc3c7).withOpacity(.5),
                                      Color(0xFF2c3e50).withOpacity(.6),
                                    ])),
                        ),
                      ],
                    ),
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
              content(font, theme, context, _bloc),
              SizedBox(
                height: 100.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: theme.brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          child: Icon(
            FontAwesomeIcons.commentAlt,
            color: theme.brightness == Brightness.light
                ? Colors.blue
                : Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            return _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Akan datang')));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => _bloc.incrementSizeSink.add(1),
              icon: Icon(FontAwesomeIcons.plus),
            ),
            IconButton(
              onPressed: () => _bloc.decrementSizeSink.add(1),
              icon: Icon(FontAwesomeIcons.minus),
            )
          ],
        ),
      ),
    );
  }

  Widget header(TextTheme font, ThemeData theme) {
    final dividerColour = Colors.grey[400];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 30.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _post.embedded.wpTerm.category.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Text(
                          _post.embedded.wpTerm.category[index].name,
                          style: font.display1.copyWith(
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
                        Visibility(
                          visible: index !=
                              _post.embedded.wpTerm.category.length - 1,
                          child: VerticalDivider(color: dividerColour),
                        )
                      ],
                    );
                  },
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
          Column(
            children: <Widget>[
              Text(
                DateFormat.MMMMd().format(_post.date) +
                    ' , ' +
                    DateFormat.jm().format(_post.date),
                style: font.display1.copyWith(
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
              Divider(
                color: dividerColour,
              ),
              author(font, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget author(TextTheme font, ThemeData theme) => Container(
        height: 20.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _post.embedded.author.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Penulis: ' + _post.embedded.author[index].name,
                style: font.display1.copyWith(
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
            );
          },
        ),
      );

  Widget content(
      TextTheme font, ThemeData theme, context, ArticlePageBloc bloc) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: StreamBuilder<double>(
          initialData: 18,
          stream: bloc.textSizeStream,
          builder: (context, AsyncSnapshot<double> snapshot) => MarkdownBody(
                styleSheet: MarkdownStyleSheet(
                  strong: font.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: snapshot.data,
                      color: theme.brightness == Brightness.light
                          ? Colors.grey[600]
                          : Colors.grey[300]),
                  p: font.body1.copyWith(
                    height: 1.3,
                    letterSpacing: 1.0,
                    fontSize: snapshot.data,
                  ),
                  a: font.body1.copyWith(
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.0,
                      fontSize: snapshot.data,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 5.0,
                            color: theme.brightness == Brightness.light
                                ? Colors.blue
                                : Colors.blue),
                      ]),
                  em: font.body1.copyWith(
                      fontStyle: FontStyle.italic, fontSize: snapshot.data),
                  h1: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  h2: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  h3: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  h4: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  h5: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  h6: font.title.copyWith(fontSize: snapshot.data - 1.0),
                  blockquotePadding: 15.0,
                  blockquoteDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: theme.brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.grey[800],
                  ),
                  blockSpacing: 25.0,
                  img: TextStyle(),
                  codeblockDecoration: BoxDecoration(),
                  horizontalRuleDecoration: BoxDecoration(
                      border:
                          Border.all(width: 1.0, color: theme.backgroundColor)),
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
      ),
    );
  }

  ArticlePage(this._post);
}
