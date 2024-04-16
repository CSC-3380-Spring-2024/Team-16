import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDTUbmKFqq4vPJRUU6N4h8TTD9vUJg5PzI",
            authDomain: "foodappproject-93753w.firebaseapp.com",
            projectId: "foodappproject-93753w",
            storageBucket: "foodappproject-93753w.appspot.com",
            messagingSenderId: "307375064168",
            appId: "1:307375064168:web:25a74f8d4640870aa367dd"));
  } else {
    await Firebase.initializeApp();
  }
}
