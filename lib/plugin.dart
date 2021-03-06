import 'package:flutter/material.dart';

class Plugin extends StatefulWidget {
  const Plugin({Key key}) : super(key: key);
  @override
  _PluginState createState() => _PluginState();
}

class _PluginState extends State<Plugin> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Hello ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' world!'),
        ],
      ),
    );
  }
}
