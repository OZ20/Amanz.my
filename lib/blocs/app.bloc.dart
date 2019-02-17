import 'package:amanzmy/apis/amanz.api.dart';
import 'package:amanzmy/blocs/bloc.provider.dart';
import 'package:flutter/material.dart';
import 'package:amanzmy/model/category.dart';

class AppPageBloc extends BlocBase {
  static final AppPageBloc _bloc = new AppPageBloc._internal();

  final GlobalKey<ScaffoldState> appScaffoldKey = new GlobalKey();
  final List<Category> _categoryList = new List();

  factory AppPageBloc() {
    return _bloc;
  }

  AppPageBloc._internal() {
    this._init();
  }

  void _init() async {
    await getCategories().then((data) => this._filterData(data));
  }

  void _filterData(List data) async {
    data.forEach((category) => _categoryList.add(Category.fromJson(category)));
  }

  Category getCategoryName(List categoryId) {
    Category actualCategory;
    _categoryList.forEach((category) {
      if (category.id == categoryId[0])
        return actualCategory = category;
    });
    return actualCategory;
  }

  @override
  void dispose() {}
}

AppPageBloc appBloc = new AppPageBloc();
