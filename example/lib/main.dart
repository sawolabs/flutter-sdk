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
  String user;
  Sawo sawo = new Sawo(
    apiKey: "396487cf-d11a-4cf3-8e15-067ce2509b53",
    hostname: "packages.sawolabs.com",
  );

  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
    }
    setState(() {
      user = payload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("UserData: $user"),
        ElevatedButton(
          onPressed: () => sawo.signIn(
              context: context,
              identifierType: 'email',
              callback: payloadCallback),
          child: Text('Email Login'),
        ),
        ElevatedButton(
          onPressed: () => sawo.signIn(
              context: context,
              identifierType: 'phone_number_sms',
              callback: payloadCallback),
          child: Text('Phone Login'),
        ),
      ]),
    );
  }
}
