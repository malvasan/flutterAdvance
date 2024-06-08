import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/main.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera.dart';

final _availablePages = <String, WidgetBuilder>{
  'First Page': (_) => const HomePage(),
  'Second Page': (_) => const Camera(),
};

final selectedPageNameProvider = StateProvider<String>((ref) {
  // default value
  return _availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  // watch for state changes inside selectedPageNameProvider
  final selectedPageKey = ref.watch(selectedPageNameProvider.state).state;
  // return the WidgetBuilder using the key as index
  return _availablePages[selectedPageKey]!;
});

final firebaseImage = StreamProvider<List<ImageFirebase>>((ref) {
  final stream = FirebaseFirestore.instance
      .collection('images')
      .orderBy('timestamp')
      .snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => ImageFirebase.fromJson(doc.data())).toList());
});
