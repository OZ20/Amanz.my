import 'package:amanzmy/blocs/article.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/model/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:youtube_player/youtube_player.dart';

class ArticlePage extends StatefulWidget {
  final Post _post;

  ArticlePage(this._post);

  @override
  State createState() {
    return _ArticlePage();
  }
}

class _ArticlePage extends State<ArticlePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Post _post;
  ArticlePageBloc _bloc;
  WebViewController _webViewController;
  VideoPlayerController _videoPlayerController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArticlePageBloc>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _bloc.sinkTabControllerIndex.add(_tabController.index);
    });
    _post = widget._post;
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final font = theme.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? Colors.grey[200]
                  : Colors.grey[800],
              borderRadius: BorderRadius.circular(40.0)),
          child: TabBar(
              isScrollable: true,
              labelColor: theme.brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              unselectedLabelColor: theme.brightness == Brightness.light
                  ? Colors.grey[900]
                  : Colors.white,
              indicator: BubbleTabIndicator(
                  insets: EdgeInsets.all(0.0),
                  indicatorColor: theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab),
              controller: _tabController,
              tabs: ['Reader', 'Web']
                  .map((data) => Container(
                        width: 50.0,
                        child: Text(
                          data,
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList()),
        ),
      ),
      body: StreamBuilder(
        initialData: _tabController.index,
        stream: _bloc.streamTabControllerIndex,
        builder: (context, snapshot) {
          if (snapshot.data == 0)
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header(font, theme, size),
                  SizedBox(
                    height: 30.0,
                  ),
                  content(font, theme, size, context),
                  SizedBox(
                    height: 100.0,
                  )
                ],
              ),
            );
          else if (snapshot.data == 1)
            return WebviewScaffold(
              scrollBar: false,
              url: _post.link,
            );
          else return Container();
        },
      ),
      floatingActionButton: StreamBuilder<int>(
          initialData: _tabController.index,
          stream: _bloc.streamTabControllerIndex,
          builder: (context, snapshot) {
            if (snapshot.data == 0)
              return FloatingActionButton(
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
                  });
            else
              return SizedBox();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: StreamBuilder<int>(
          initialData: _tabController.index,
          stream: _bloc.streamTabControllerIndex,
          builder: (context, snapshot) {
            if (snapshot.data == 0)
              return BottomAppBar(
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
              );
            else
              return SizedBox();
          }),
    );
  }

  Widget header(TextTheme font, ThemeData theme, Size size) {
    final dividerColour = Colors.grey[400];
    return Column(
      children: <Widget>[
        Visibility(
            visible: _post.jpFeaturedMedia.isEmpty,
            child: SizedBox(
              height: 50.0,
            )),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Visibility(
                visible: _post.jpFeaturedMedia.isNotEmpty,
                child: Container(
                  height: 300.0,
                  child: Hero(
                    tag: _post.id,
                    child: CachedNetworkImage(
                        width: size.width,
                        fit: BoxFit.cover,
                        imageUrl: _post.jpFeaturedMedia),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Visibility(
                visible: _post.jpFeaturedMedia.isNotEmpty,
                child: Hero(
                  tag: '${_post.id}' + 'gradient',
                  child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                        gradient: theme.brightness == Brightness.light
                            ? LinearGradient(
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                                colors: [
                                    Color(0xFF4286f4).withOpacity(.1),
                                    Color(0xFF373B44).withOpacity(.8),
                                  ])
                            : LinearGradient(
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                                colors: [
                                    Colors.transparent,
                                    Color(0xFFbdc3c7).withOpacity(.1),
                                    Color(0xFF2c3e50).withOpacity(.8),
                                  ])),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: Container(
                      height: 20.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _post.embedded.wpTerm.category.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Text(
                                _post.embedded.wpTerm.category[index].name,
                                style: font.display1.copyWith(
                                  background: Paint()
                                    ..strokeWidth = 10.0
                                    ..color =
                                        theme.brightness == Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.white
                                      : Colors.black,
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
                  Hero(
                    tag: '${_post.id}: tajuk',
                    child: Text(
                      HtmlUnescape().convert(_post.title['rendered']),
                      textAlign: TextAlign.start,
                      style: font.title.copyWith(
                        fontSize: 30.0,
                        background: Paint()
                          ..color = theme.brightness == Brightness.light
                              ? Colors.white
                              : Colors.black,
                        color: theme.brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat.MMMMd().format(_post.date) +
                    ' , ' +
                    DateFormat.jm().format(_post.date),
                textAlign: TextAlign.start,
                style: font.display1.copyWith(
                  background: Paint()
                    ..strokeWidth = 10.0
                    ..color = theme.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: author(font, theme),
              ),
              Divider(
                color: dividerColour,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget author(TextTheme font, ThemeData theme) => Container(
        height: 20.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _post.embedded.author.length,
          itemBuilder: (context, index) {
            return Text(
              'Penulis: ' + _post.embedded.author[index].name,
              style: font.display1.copyWith(
                background: Paint()
                  ..strokeWidth = 10.0
                  ..color = theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                color: theme.brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
              ),
            );
          },
        ),
      );

  Widget content(TextTheme font, ThemeData theme, Size size, mainContext) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: StreamBuilder<double>(
          initialData: 18,
          stream: _bloc.textSizeStream,
          builder: (context, AsyncSnapshot<double> snapshot) => Html(
                data: _post.content['rendered'],
                useRichText: true,
//                renderNewlines: true,
                blockSpacing: 15.0,
                defaultTextStyle: font.body1.copyWith(
                  wordSpacing: 0.2,
                  height: 1.35,
                  fontSize: snapshot.data,
                ),
                onLinkTap: (data) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewScaffold(
                            appBar: AppBar(),
                            initialChild: Container(
                                child:
                                    Center(child: CircularProgressIndicator())),
                            primary: true,
                            withJavascript: true,
                            hidden: true,
                            scrollBar: true,
                            appCacheEnabled: true,
                            url: data))),
                customRender: (node, widget) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case 'iframe':
                        var videoUrl = node.attributes['src'].substring(30, 41);
                        return YoutubePlayer(
                            onError: (error) => throw error,
                            callbackController: (controller) =>
                                _videoPlayerController = controller,
                            width: size.width - 50,
                            showThumbnail: true,
                            autoPlay: false,
                            source: videoUrl,
                            context: mainContext,
                            quality: YoutubeQuality.HIGH);
                    }
                  }
                },
              ),
//              MarkdownBody(
//                styleSheet: MarkdownStyleSheet(
//                  strong: font.body1.copyWith(
//                      fontWeight: FontWeight.bold,
//                      fontSize: snapshot.data,
//                      color: theme.brightness == Brightness.light
//                          ? Colors.grey[600]
//                          : Colors.grey[300]),
//                  p: font.body1.copyWith(
//                    height: 1.3,
//                    letterSpacing: 1.0,
//                    fontSize: snapshot.data,
//                  ),
//                  a: font.body1.copyWith(
//                      decoration: TextDecoration.underline,
//                      letterSpacing: 1.0,
//                      fontSize: snapshot.data,
//                      fontStyle: FontStyle.italic,
//                      color: Colors.blue,
//                      shadows: <Shadow>[
//                        Shadow(
//                            blurRadius: 5.0,
//                            color: theme.brightness == Brightness.light
//                                ? Colors.blue
//                                : Colors.blue),
//                      ]),
//                  em: font.body1.copyWith(
//                      fontStyle: FontStyle.italic, fontSize: snapshot.data),
//                  h1: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  h2: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  h3: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  h4: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  h5: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  h6: font.title.copyWith(fontSize: snapshot.data - 1.0),
//                  blockquotePadding: 15.0,
//                  blockquoteDecoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10.0),
//                    color: theme.brightness == Brightness.light
//                        ? Colors.grey[200]
//                        : Colors.grey[800],
//                  ),
//                  blockSpacing: 25.0,
//                  img: TextStyle(),
//                  codeblockDecoration: BoxDecoration(),
//                  horizontalRuleDecoration: BoxDecoration(
//                      border:
//                          Border.all(width: 1.0, color: theme.backgroundColor)),
//                ),
//                data: '   ' + html2md.convert(_post.content['rendered']),
//                onTapLink: (data) => Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => WebviewScaffold(
//                            appBar: AppBar(),
//                            initialChild: Container(
//                                child:
//                                    Center(child: CircularProgressIndicator())),
//                            primary: true,
//                            withJavascript: true,
//                            hidden: true,
//                            scrollBar: true,
//                            appCacheEnabled: true,
//                            url: data))),
//              ),
        ),
      ),
    );
  }
}
