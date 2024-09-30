import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/firebase_options.dart';
import 'package:wisy_mobile_challenge/src/autoroute/autoroute.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/images_list.dart';
import 'package:wisy_mobile_challenge/src/utils/observers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
    observers: [MyObserver()],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        //home: const RootPage(),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
