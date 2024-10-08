import 'package:wisy_mobile_challenge/src/data/repositories/data_base_repository.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'images_list_controller.g.dart';

@riverpod
Stream<List<ImageFirebase>> firebaseImage(
  FirebaseImageRef ref,
) {
  return ref.watch(dataBaseRepositoryProvider).retrieveImages();
}
