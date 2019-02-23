import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final TextEditingController editingController;
  final VoidCallback clearValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: editingController,
      onChanged: onChanged,
      focusNode: focusNode,
      cursorColor:
          theme.brightness == Brightness.light ? Colors.blue : Colors.white,
      keyboardAppearance: theme.brightness,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Carian',
          suffixIcon: focusNode.hasFocus
              ? GestureDetector(
                  onTap: clearValue,
                  child: Icon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.grey[600],
                    size: 18.0,
                  ),
                )
              : null,
          prefixIcon: Icon(
            FontAwesomeIcons.search,
            color: Colors.grey[600],
            size: 12.0,
          ),
          filled: true,
          fillColor: theme.brightness == Brightness.light ? Colors.grey[200] : Colors.grey[900]),
    );
  }

  SearchBar(
      {@required this.focusNode,
      @required this.onChanged,
      @required this.clearValue,
      this.editingController});
}
