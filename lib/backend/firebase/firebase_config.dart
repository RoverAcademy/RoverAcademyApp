import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBfTUTFA2tII-7a72RIuTXdFq8Izi-mC1E",
            authDomain: "fbla-1fd53.firebaseapp.com",
            projectId: "fbla-1fd53",
            storageBucket: "fbla-1fd53.firebasestorage.app",
            messagingSenderId: "641289132967",
            appId: "1:641289132967:web:5500220f0342657296b482",
            measurementId: "G-GY5J5Q3D9X"));
  } else {
    await Firebase.initializeApp();
  }
}
