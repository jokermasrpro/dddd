// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCuUWHEA6WGGngzbRijTC5h2Sa7it50iDs',
    appId: '1:826207841636:web:154766fca7a909c9f55e71',
    messagingSenderId: '826207841636',
    projectId: 'insta-bcb82',
    authDomain: 'insta-bcb82.firebaseapp.com',
    storageBucket: 'insta-bcb82.firebasestorage.app',
    measurementId: 'G-7FVVQSKRLN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0k9JbwP6i290rcXvj3C_MTyjYHuxGmnI',
    appId: '1:826207841636:android:cc2b6b4d8322999df55e71',
    messagingSenderId: '826207841636',
    projectId: 'insta-bcb82',
    storageBucket: 'insta-bcb82.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrpddtMpZ-LD2QC69O9Ljs4WPf-sqaNNg',
    appId: '1:826207841636:ios:2994dfea742e05b1f55e71',
    messagingSenderId: '826207841636',
    projectId: 'insta-bcb82',
    storageBucket: 'insta-bcb82.firebasestorage.app',
    iosBundleId: 'com.example.cloneInstagram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrpddtMpZ-LD2QC69O9Ljs4WPf-sqaNNg',
    appId: '1:826207841636:ios:2994dfea742e05b1f55e71',
    messagingSenderId: '826207841636',
    projectId: 'insta-bcb82',
    storageBucket: 'insta-bcb82.firebasestorage.app',
    iosBundleId: 'com.example.cloneInstagram',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCuUWHEA6WGGngzbRijTC5h2Sa7it50iDs',
    appId: '1:826207841636:web:f28416d72eebd456f55e71',
    messagingSenderId: '826207841636',
    projectId: 'insta-bcb82',
    authDomain: 'insta-bcb82.firebaseapp.com',
    storageBucket: 'insta-bcb82.firebasestorage.app',
    measurementId: 'G-6X5D57HQZG',
  );
}
