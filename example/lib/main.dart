import 'package:flutter/material.dart';
import 'package:sawo_sdk/sawo_sdk.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Sawo Login Example',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sawo login example'),
      ),
      body: const Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  // sawo object for Android/ios
  Sawo sawo = Sawo(
    apiKey: "",
    secretKey: "",
  );

  // user payload
  String user = "";

  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.isEmpty)) {
      payload = "Login Failed :(";
    }
    setState(() {
      user = payload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UserData :- $user"),
            ElevatedButton(
              onPressed: () {
                sawo.signIn(
                  context: context,
                  identifierType: 'email',
                  callback: payloadCallback,
                );
              },
              child: const Text('Email Login'),
            ),
            ElevatedButton(
              onPressed: () {
                sawo.signIn(
                  context: context,
                  identifierType: 'phone_number_sms',
                  callback: payloadCallback,
                );
              },
              child: const Text('Phone Login'),
            ),
          ],
        ),
      ),
    );
  }
}
