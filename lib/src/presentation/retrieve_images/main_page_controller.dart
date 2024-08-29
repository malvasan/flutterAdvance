import 'dart:developer';

import 'package:wisy_mobile_challenge/src/data/repositories/firebase_repository.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'main_page_controller.g.dart';

@riverpod
Stream<List<ImageFirebase>> firebaseImage(
  FirebaseImageRef ref,
) {
  log('build: firebaseImage');
  ref.onDispose(() => log('dispose: firebaseImage'));
  ref.onCancel(() => log('cancel: firebaseImage'));
  ref.onResume(() => log('resume: firebaseImage'));
  ref.onAddListener(() => log('add listener: firebaseImage'));
  ref.onRemoveListener(() => log('remove listener: firebaseImage'));
  return ref.watch(firebaseRepositoryProvider).retrieveImages();
}
