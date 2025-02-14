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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmcM8dIl0EZSgxMUy5ASL0aLimAr2Vdr8',
    appId: '1:783351988819:android:78416967374c29e17dfca6',
    messagingSenderId: '783351988819',
    projectId: 'bosm-roulette-2023',
    storageBucket: 'bosm-roulette-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1VpwFosy-NE2hSL0UcSXF0Jic9_ZnhTM',
    appId: '1:783351988819:ios:0ee89c2ec539741f7dfca6',
    messagingSenderId: '783351988819',
    projectId: 'bosm-roulette-2023',
    storageBucket: 'bosm-roulette-2023.appspot.com',
    androidClientId: '783351988819-4fvnp0keirfeiocctf8sh72umortmmo8.apps.googleusercontent.com',
    iosClientId: '783351988819-r4tig44g8nltei896b71n81r1kstsb7h.apps.googleusercontent.com',
    iosBundleId: 'com.bitspilani.bosm2023',
  );
}
