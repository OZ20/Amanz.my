import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final itemName;
  final itemIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(itemIcon),
        SizedBox(
          width: 15.0,
        ),
        Text(itemName),
      ],
    );
  }

  MenuItem(this.itemName, this.itemIcon);
}
