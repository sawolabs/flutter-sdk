import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:uuid/uuid.dart';

class Sawo {
  String apiKey;
  String secretKey;
  String identifierType;

  // constructor
  Sawo({
    @required this.apiKey,
    @required this.secretKey,
  }) {
    assert(this.apiKey != null, "API Key ID is required");
    assert(this.secretKey != null, "API Key ID is required");
  }

  signIn({BuildContext context, identifierType, callback}) async {
    identifierType = identifierType;
    // Navigator.push returns a Future that completes after calling
    //@required this.identifierType
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewContainer(
          apiKey: apiKey,
          secretKey: secretKey,
          navContext: context,
          identifierType: identifierType,
        ),
      ),
    );
    callback(context, result);
  }
}

// ignore: must_be_immutable
class WebViewContainer extends StatefulWidget {
  String apiKey;
  String secretKey;
  String identifierType;
  BuildContext navContext;

  WebViewContainer({
    this.apiKey,
    this.secretKey,
    this.navContext,
    this.identifierType,
  });
  @override
  createState() => _WebViewContainerState(
      apiKey: apiKey,
      secretKey: secretKey,
      navContext: navContext,
      identifierType: identifierType);
}

class _WebViewContainerState extends State<WebViewContainer> {
  String apiKey;
  String secretKey;
  String identifierType;
  BuildContext navContext;

  var _webviewKey = UniqueKey();

  // webview constants
  var _webviewURL;
  var _eventPrefix;
  WebViewController _controller;

  _WebViewContainerState({
    this.apiKey,
    this.secretKey,
    this.navContext,
    this.identifierType,
  });

  @override
  void initState() {
    _eventPrefix = Uuid().v1();
    var url = "https://websdk.sawolabs.com/?eventPrefix=$_eventPrefix";
    _webviewURL = url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              key: _webviewKey,
              initialUrl: _webviewURL,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'messageHandler',
                    onMessageReceived: (JavascriptMessage message) {
                      var _payload = message.message;
                      Navigator.pop(navContext, _payload);
                    }),
              ]),
              onWebViewCreated: (WebViewController webviewController) {
                _controller = webviewController;
              },
              onPageStarted: (String url) {
                _controller.evaluateJavascript(_postJSMessage());
              },
            ),
          )
        ],
      ),
    );
  }

  String _postJSMessage() {
    var _eventLoadConfig = _eventPrefix + "LOAD_CONFIG";
    var _eventLoadSuccess = _eventPrefix + "LOAD_SUCCESS";
    var _eventLoginSuccess = _eventPrefix + "LOGIN_SUCCESS";
    var script = '''
      window.addEventListener('message', function(e) {
        switch(e.data.event){
          case '$_eventLoadSuccess':
            window.postMessage({
              event: '$_eventLoadConfig',
              payload: {
                identifierType: '$identifierType',
                apiKey: '$apiKey',
                secretKey: '$secretKey'
              }
            }, '*');
            break;

          case '$_eventLoginSuccess':
            if (messageHandler?.postMessage) messageHandler.postMessage(JSON.stringify(e.data.payload))
            break;

          default:
            console.log('SAWO: default swtich case ', JSON.stringify(e.data))
        }
      });
    ''';
    return script;
  }
}
