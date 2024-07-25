import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';

final firebaseImage = StreamProvider<List<ImageFirebase>>((ref) {
  final stream = FirebaseFirestore.instance
      .collection('images')
      .orderBy('timestamp')
      .snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => ImageFirebase.fromJson(doc.data())).toList());
});
