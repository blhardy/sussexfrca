// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8z7-IRTrR7QSmpUlHFUyJc7B8rjn7DYU',
    appId: '1:917360072010:web:5aa98e2fd6511cb0be1db3',
    messagingSenderId: '917360072010',
    projectId: 'sussexprimarymcq',
    authDomain: 'sussexprimarymcq.firebaseapp.com',
    databaseURL:
        'https://sussexprimarymcq-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sussexprimarymcq.appspot.com',
    measurementId: 'G-XZHYZJDGBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXsnk-gVPFYPqDx7rZj1K5-bYxy1cbPww',
    appId: '1:917360072010:android:92c86559df60958bbe1db3',
    messagingSenderId: '917360072010',
    projectId: 'sussexprimarymcq',
    databaseURL:
        'https://sussexprimarymcq-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sussexprimarymcq.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnIEpMz3_tbnKPH8NSqQY52ENG3LrIZJ0',
    appId: '1:917360072010:ios:196179e08df60d9abe1db3',
    messagingSenderId: '917360072010',
    projectId: 'sussexprimarymcq',
    databaseURL:
        'https://sussexprimarymcq-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sussexprimarymcq.appspot.com',
    iosClientId:
        '917360072010-a2hvgf4bj4udhq58k9oclrji142n077t.apps.googleusercontent.com',
    iosBundleId: 'com.easyfrca.sussexfrca',
  );
}
