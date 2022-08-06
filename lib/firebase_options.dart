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
    apiKey: 'AIzaSyDDfx7okHYerMZ93eEzr7d0ypHWv5N4IRA',
    appId: '1:637158543994:web:f70f7ea337c79b25b821c3',
    messagingSenderId: '637158543994',
    projectId: 'etutor-9e832',
    authDomain: 'etutor-9e832.firebaseapp.com',
    storageBucket: 'etutor-9e832.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMv-LZSVt5aKt4mj5Z87OQ4EmX0GQ8hv0',
    appId: '1:637158543994:android:590f34df3a7196fcb821c3',
    messagingSenderId: '637158543994',
    projectId: 'etutor-9e832',
    storageBucket: 'etutor-9e832.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOyreB3dNYZAHTt1msdlPQgcSGYQ6nQAU',
    appId: '1:637158543994:ios:31786ae9629932eeb821c3',
    messagingSenderId: '637158543994',
    projectId: 'etutor-9e832',
    storageBucket: 'etutor-9e832.appspot.com',
    iosClientId: '637158543994-hmr27muavudncr120oknl61jp759v0sq.apps.googleusercontent.com',
    iosBundleId: 'com.example.etutor',
  );
}
