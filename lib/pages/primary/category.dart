import 'package:amanzmy/blocs/app.bloc.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:amanzmy/blocs/category.bloc.dart';
import 'package:amanzmy/blocs/ulasan.bloc.dart';
import 'package:amanzmy/model/post.dart';
import 'package:amanzmy/pages/primary/ulasan.dart';
import 'package:amanzmy/util/search-state.dart';
import 'package:amanzmy/widget/search-bar.dart';
import 'package:amanzmy/widget/search-card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPage extends StatefulWidget {
  @override
  State createState() {
    return _CategoryPage();
  }
}

class _CategoryPage extends State<CategoryPage> {
  final FocusNode searchNode = FocusNode();
  final TextEditingController editingController = TextEditingController();

  CategoryPageBloc _bloc;
  Size size;
  ThemeData theme;
  TextTheme font;
  int builds = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CategoryPageBloc>(context)..init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    font = theme.textTheme;
//    this.clear();
  }

  void clear() {
    _bloc.clear();
    searchNode.unfocus();
    editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => appBloc.appScaffoldKey.currentState.openDrawer(),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset('assets/img/amanz-logo-single.jpg'),
              )),
        ),
        title: SearchBar(
          clearValue: () => clear(),
          focusNode: searchNode,
          editingController: editingController,
          onChanged: (value) => _bloc.querySink.add(value),
        ),
      ),
      body: body(),
    );
  }

  Widget body() => SingleChildScrollView(
        key: _bloc.scrollViewKey,
        child: Column(
          children: <Widget>[
            Container(
              color: theme.backgroundColor,
              child: Column(
                children: <Widget>[
                  Container(
                    color: theme.brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                    width: size.width,
                    child: StreamBuilder(
                      initialData: SearchState.onInitial,
                      stream: _bloc.loadingInitialStream,
                      builder: (context, AsyncSnapshot<SearchState> snapshot) {
                        if (snapshot.data == SearchState.onSuccess)
                          return StreamBuilder(
                              stream: _bloc.postStream,
                              builder: (context,
                                  AsyncSnapshot<List<Post>> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) => Column(
                                            children: <Widget>[
                                              SearchCard(snapshot.data[index]),
                                              Visibility(
                                                visible: index !=
                                                    snapshot.data.length - 1,
                                                child: Divider(
                                                  color: theme.brightness ==
                                                          Brightness.light
                                                      ? Colors.grey[300]
                                                      : Colors.grey[800],
                                                ),
                                              )
                                            ],
                                          ));
                                } else
                                  return SizedBox();
                              });
                        else if (snapshot.data == SearchState.onInitial) {
                          return Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.search),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Mau cari apa abam?',
                                    style: font.title,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.data == SearchState.onLoading) {
                          return Center(
                            child: LinearProgressIndicator(),
                          );
                        } else {
                          return Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.signal_wifi_off),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Ada problem lah bang, check internet tu ',
                                    style: font.title,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: _bloc.shouldLoadMoreStream,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data)
                          return StreamBuilder(
                              initialData: SearchState.onInitial,
                              stream: _bloc.loadingMoreStream,
                              builder: (context,
                                  AsyncSnapshot<SearchState> snapshot) {
                                switch (snapshot.data) {
                                  case SearchState.onInitial:
                                    return loadMore();
                                  case SearchState.onLoading:
                                    return Center(
                                      child: LinearProgressIndicator(),
                                    );
                                  case SearchState.onSuccess:
                                    return loadMore();
                                  case SearchState.onError:
                                }
                              });
                        else
                          return SizedBox();
                      }),
                  Visibility(
                      visible: searchNode.hasFocus,
                      child: SizedBox(
                        height: 5.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            listCategory()
          ],
        ),
      );

  Widget loadMore() => RaisedButton(
      color: Colors.white,
      child: Text('Lihat lagi'),
      onPressed: () {
        _bloc.loadingMoreSink.add(SearchState.onLoading);
        _bloc.getMorePost(editingController.value.text, _bloc.postListLength);
      });

  Widget listCategory() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<UlasanPageBloc>(
                        child: UlasanPage(), bloc: UlasanPageBloc()))),
            title: Text(
              'Ulasan',
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text('Promo', textAlign: TextAlign.center),
            subtitle: Text('Coming sooon..', textAlign: TextAlign.center),
          ),
          ListTile(
            title: Text('TV', textAlign: TextAlign.center),
            subtitle: Text('Coming sooon..', textAlign: TextAlign.center),
          ),
          ListTile(
            title: Text('Tips', textAlign: TextAlign.center),
            subtitle: Text('Coming sooon..', textAlign: TextAlign.center),
          ),
        ],
      );

  @override
  void dispose() {
    super.dispose();
    searchNode.dispose();
  }
}
