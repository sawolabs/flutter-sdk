import 'package:flutter/foundation.dart';

class Sawo {
  String apiKeyID;
  String identifier;
  Function successCallback;
  Function failureCallback;
  String input;

  Sawo({@required this.apiKeyID}) {
    assert(this.apiKeyID != null, "API Key ID is required");
  }

  void signInWithEmail(
      {@required email, @required successCallback, @required failureCallback}) {
    print("signInWithEmail is invoked ....................");
    this.input = email;
    this.successCallback = successCallback;
    this.failureCallback = failureCallback;

    print('The value of the input is: ${this.input}');
    print('The value of the function is: ${this.successCallback}');
    this.successCallback();
  }
}
