import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_base_repository.g.dart';

class DataBaseRepository {
  DataBaseRepository(this.instance);
  final FirebaseFirestore instance;

  Stream<List<ImageFirebase>> retrieveImages() {
    final stream =
        instance.collection('images').orderBy('timestamp').snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => ImageFirebase.fromJson(doc.data()))
        .toList());
  }

  Future<String> addImage(ImageMetadata image) async {
    final collRef = instance.collection('images');
    final doc = await collRef.add(image.toJson());
    return doc.id;
  }

  Future<void> setImage(ImageMetadata image, String docId) async {
    final collRef = instance.collection('images');
    await collRef.doc(docId).set(image.toJson());
  }
}

@Riverpod(keepAlive: true)
DataBaseRepository dataBaseRepository(DataBaseRepositoryRef ref) {
  return DataBaseRepository(FirebaseFirestore.instance);
}
