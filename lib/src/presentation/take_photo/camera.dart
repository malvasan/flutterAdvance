import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exif/exif.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/application/take_photo/camera_utils.dart';

class Camera extends ConsumerWidget {
  const Camera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Orientation orientation = MediaQuery.of(context).orientation;
    String imageURL = '';
    return Scaffold(
        body: Container(
      color: Colors.white,
      // child: CameraAwesomeBuilder.awesome(
      //   topActionsBuilder: (state) => AwesomeTopActions(
      //     state: state,
      //     children: [
      //       ElevatedButton(
      //           onPressed: () => ref
      //               .read(selectedPageNameProvider.state)
      //               .state = 'First Page',
      //           child: const Icon(Icons.arrow_back))
      //     ],
      //   ),
      //   saveConfig: SaveConfig.photoAndVideo(
      //     photoPathBuilder: () => path(CaptureMode.photo),
      //     videoPathBuilder: () => path(CaptureMode.video),
      //     initialCaptureMode: CaptureMode.photo,
      //   ),
      //   onMediaTap: (mediaCapture) {
      //     print('Tap on ${mediaCapture.filePath}');
      //     OpenFile.open(mediaCapture.filePath);
      //   },
      // ),
      child: CameraAwesomeBuilder.custom(
        builder: (cameraState, previewSize, previewRect) {
          cameraState.captureState$.listen((MediaCapture? mediaCapture) async {
            if (mediaCapture != null) {
              final capture = mediaCapture;
              switch (mediaCapture.status) {
                case MediaCaptureStatus.success:
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                  Reference referenceImageUploaded = referenceDirImages
                      .child(capture.filePath.split('test/')[1]);
                  try {
                    if (File(capture.filePath).existsSync()) {
                      await referenceImageUploaded
                          .putFile(File(capture.filePath));
                      imageURL = await referenceImageUploaded.getDownloadURL();

                      final fileBytes =
                          File(capture.filePath).readAsBytesSync();
                      final data = await readExifFromBytes(fileBytes);
                      if (data.isNotEmpty) {
                        final imageMetadata = <String, dynamic>{
                          'url': imageURL,
                          'orientation': normalizeOrientation(
                              data['Image Orientation']?.printable ?? ''),
                          'timestamp': convertStringToDateTime(
                              data['Image DateTime']?.printable ??
                                  '2000:00:00 00:00:00'),
                          'latitude': data['GPS GPSLatitude']?.printable,
                          'longitude': data['GPS GPSLongitude']?.printable,
                        };
                        CollectionReference collRef =
                            FirebaseFirestore.instance.collection('images');
                        collRef.add(imageMetadata);
                      }
                    }
                  } catch (error) {
                    print(error);
                  }
                  // Image captured, perform additional code (e.g., get the file path)
                  //print("Image captured: ${mediaCapture.filePath}");
                  break;
                case MediaCaptureStatus.capturing:
                  print("Capturing in progress...");
                case MediaCaptureStatus.failure:
                  print("Capture failed!");
              }
            }
          });
          return AwesomeCameraLayout(
            state: cameraState,
            topActions: ElevatedButton(
                // onPressed: () => ref
                //     .read(selectedPageNameProvider.state)
                //     .state = 'First Page',
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
            //topActions: AwesomeTopActions(state: cameraState),
            onMediaTap: (mediaCapture) {
              OpenFile.open(mediaCapture.filePath);
            },
          );
        },
        saveConfig: SaveConfig.photoAndVideo(
          photoPathBuilder: () => path(CaptureMode.photo),
          videoPathBuilder: () => path(CaptureMode.video),
          initialCaptureMode: CaptureMode.photo,
        ),
      ),
    ));
  }
}
