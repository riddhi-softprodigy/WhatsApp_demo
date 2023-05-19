import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCu-psp9UAMEKV-bIlUo4i0GQzLz6ZQ5us",
            authDomain: "whatsapp-783fc.firebaseapp.com",
            projectId: "whatsapp-783fc",
            storageBucket: "whatsapp-783fc.appspot.com",
            messagingSenderId: "1091390578867",
            appId: "1:1091390578867:web:78b840339ba35db7e310c6"));
  } else {
    await Firebase.initializeApp();
  }
}
