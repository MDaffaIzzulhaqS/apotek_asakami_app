// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCbLoiIhC6v3efMEfKwRYS8d3joYNyDlZY',
    appId: '1:408216932264:web:39fc96d6e3a459fa9b979d',
    messagingSenderId: '408216932264',
    projectId: 'apotekasakamiapp',
    authDomain: 'apotekasakamiapp.firebaseapp.com',
    storageBucket: 'apotekasakamiapp.appspot.com',
    measurementId: 'G-TRTTJFTW7Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWLQMxB2iqN6gWrnpTm0n6fxKy-xmTyp4',
    appId: '1:408216932264:android:1bc0846c36edec5b9b979d',
    messagingSenderId: '408216932264',
    projectId: 'apotekasakamiapp',
    storageBucket: 'apotekasakamiapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWJreeivqZugbKZgtE2WWwL5gCWTzdsao',
    appId: '1:408216932264:ios:9fdef07284b43a179b979d',
    messagingSenderId: '408216932264',
    projectId: 'apotekasakamiapp',
    storageBucket: 'apotekasakamiapp.appspot.com',
    iosBundleId: 'com.example.apotekAsakamiApp',
  );
}
