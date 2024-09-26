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
    apiKey: 'AIzaSyC4bGV4Y71UAupstIfU385L6wpIAstUpkU',
    appId: '1:625334484144:web:91512ef5366dc32ae6cf75',
    messagingSenderId: '625334484144',
    projectId: 'mekongnetems-63ac1',
    authDomain: 'mekongnetems-63ac1.firebaseapp.com',
    storageBucket: 'mekongnetems-63ac1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiKxNIikzJZderUnKbtaQSR11UOL08Q7c',
    appId: '1:625334484144:android:9eb109aa0bb6b33ae6cf75',
    messagingSenderId: '625334484144',
    projectId: 'mekongnetems-63ac1',
    storageBucket: 'mekongnetems-63ac1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdyd9rTTRjvxXfwhOCkVKPK2gkvbsCmCg',
    appId: '1:625334484144:ios:1c9e7ccf478fb3a0e6cf75',
    messagingSenderId: '625334484144',
    projectId: 'mekongnetems-63ac1',
    storageBucket: 'mekongnetems-63ac1.appspot.com',
    iosBundleId: 'com.mekongnet.ems',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdyd9rTTRjvxXfwhOCkVKPK2gkvbsCmCg',
    appId: '1:625334484144:ios:1c9e7ccf478fb3a0e6cf75',
    messagingSenderId: '625334484144',
    projectId: 'mekongnetems-63ac1',
    storageBucket: 'mekongnetems-63ac1.appspot.com',
    iosBundleId: 'com.mekongnet.ems',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4bGV4Y71UAupstIfU385L6wpIAstUpkU',
    appId: '1:625334484144:web:4de10b4a256cfdcce6cf75',
    messagingSenderId: '625334484144',
    projectId: 'mekongnetems-63ac1',
    authDomain: 'mekongnetems-63ac1.firebaseapp.com',
    storageBucket: 'mekongnetems-63ac1.appspot.com',
  );

}