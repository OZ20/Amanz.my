import 'package:amanzmy/widget/menu-item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nak setting apa bang'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: <Widget>[
            ListTile(
                onTap: () => showAboutDialog(
                      context: context,
                      applicationName: 'Amanz',
                      applicationVersion: 'alpha v0.22',
                      applicationLegalese: 'Untuk Amanz & Komuniti',
                    ),
                title: MenuItem('versi', FontAwesomeIcons.codeBranch))
          ],
        ),
      ),
    );
  }
}
