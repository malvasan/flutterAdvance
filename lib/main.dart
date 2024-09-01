import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/firebase_options.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/main_page.dart';
import 'package:wisy_mobile_challenge/src/utils/observers.dart';

//aca se ve el cambio en
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    observers: [MyObserver()],
    child: HomePage(),
  ));
}
