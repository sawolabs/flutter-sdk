import 'package:flutter/material.dart';
import 'package:sawo/sawo.dart';

void main() {
  runApp(MaterialApp(
    title: 'Sawo Login Example',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sawo login example'),
      ),
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatefulWidget {
  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  // Sawo configuration object
  var config = {};
  // user payload
  String user;
  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
    }
    setState(() {
      user = payload;
    });
  }

  void toogleState(typedata, text) => setState(() {
        config[typedata] = text;
      });

  @override
  Widget build(BuildContext context) {
    Sawo sawo;
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          onChanged: (text) {
            toogleState("apiKey", text);
          },
          decoration:
              InputDecoration(hintText: 'API Key', labelText: 'API Key'),
        ),
        TextField(
          onChanged: (text) {
            toogleState("hostname", text);
          },
          decoration:
              InputDecoration(hintText: 'Hostname', labelText: 'Hostname'),
        ),
        Text("UserData :- $user"),
        ElevatedButton(
          onPressed: () {
            Sawo sawo = new Sawo(
              apiKey: config["apiKey"],
              hostname: config["hostname"],
            );
            sawo.signIn(
              context: context,
              identifierType: 'email',
              callback: payloadCallback,
            );
          },
          child: Text('Email Login'),
        ),
        ElevatedButton(
          onPressed: () {
            Sawo sawo = new Sawo(
              apiKey: config["apiKey"],
              hostname: config["hostname"],
            );
            sawo.signIn(
              context: context,
              identifierType: 'phone_number_sms',
              callback: payloadCallback,
            );
          },
          child: Text('Phone Login'),
        ),
      ]),
    );
  }
}
