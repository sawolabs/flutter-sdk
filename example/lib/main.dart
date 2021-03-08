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
            toogleState("secretKey", text);
          },
          decoration:
              InputDecoration(hintText: 'SecretKey', labelText: 'SecretKey'),
        ),
        Text("UserData :- $user"),
        ElevatedButton(
          onPressed: () {
            Sawo(
              apiKey: config["apiKey"],
              secretKey: config["secretKey"],
            ).signIn(
              context: context,
              identifierType: 'email',
              callback: payloadCallback,
            );
          },
          child: Text('Email Login'),
        ),
        ElevatedButton(
          onPressed: () {
            Sawo(
              apiKey: config["apiKey"],
              secretKey: config["secretKey"],
            ).signIn(
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
