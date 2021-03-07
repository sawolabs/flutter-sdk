# Sawo
Passwordless and OTP-less Authentication for your website. It helps you to authenticate user via their email or phone number.

## Getting Started
* [Documentation](https://docs.sawolabs.com/sawo)
* [Developer dashboard](https://dev.sawolabs.com/)

To get started, you can [create a free account at SAWO](https://dev.sawolabs.com/) to get your API keys.

## Installing

A step by step series of examples that tell you how to get a development env running. These instructions will let you render the form in your speicified container, and allow you to attach successful login callback for futher actions.

#### Add the plugin in dependencies

```
dependencies:
  sawo: ^0.0.6
```

#### Install the plugin, by running mentioned command

```
flutter pub get
```

#### Import the plugin into class
```
import 'package:sawo/sawo.dart';
```

#### Create API Key
* Login to sawo [dev console.](dev.sawolabs.com)
* Create a new project
    * Set Project Name
    * Set Project Host
        *  For dev: point to localhost
        *  For prod: point to your domain.
*  Copy your API key & hostname

#### Create a Sawo Instance
```dart
    Sawo sawo = new Sawo(
        apiKey: <YOUR-API-KEY>,
        hostname: <YOUR-HOSTNAME>,
     );
```


#### Redirect User to login page
* sawo provides two ways to authenticate user, one by email and one by phone number.

```dart

    void payloadCallback(context, payload) {
        // BuildContext Context
        // String payload || null
    }
    
    @override
      Widget build(BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
                Text("UserData After Login: $user"),
                ElevatedButton(
                    onPressed: () => sawo.singIn(
                        context: context, // BuildContext
                        identifierType: 'email', // email identifier
                        callback: payloadCallback // your callback method to receive a user payload
                    ),
                    child: Text('Email Login'),
                ),
                ElevatedButton(
                    onPressed: () => sawo.singIn(
                        context: context, // BuildContext
                        identifierType: 'phone_number_sms', // email identifier
                        callback: payloadCallback // your callback method to receive a user payload
                    ),
                    child: Text('Phone Login'),
                ),
          ]),
        );
      }
```

when user successfully verified, the callback method will get invoked with the payload which contains userID, and is something went wrong the payload will get null.

## [Sawo Example Project](https://pub.dev/packages/sawo/example)

## Versioning

We use [SemVer](https://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors
* [SAWO Labs](https://github.com/sawolab)
* [Chander Prakash](https://github.com/chander-prakash)

## License

This project is licensed under the MIT License