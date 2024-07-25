import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera_controller.dart';

class Camera extends ConsumerWidget {
  const Camera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: CameraAwesomeBuilder.custom(
        builder: (cameraState, previewSize, previewRect) {
          cameraState.captureState$.listen((MediaCapture? mediaCapture) async {
            if (mediaCapture != null) {
              final capture = mediaCapture;
              switch (mediaCapture.status) {
                case MediaCaptureStatus.success:
                  await ref
                      .read(cameraControllerProvider)
                      .uploadImage(capture.filePath);
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
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
            onMediaTap: (mediaCapture) {
              OpenFile.open(mediaCapture.filePath);
            },
          );
        },
        saveConfig: SaveConfig.photoAndVideo(
          photoPathBuilder: () =>
              ref.read(cameraControllerProvider).path(CaptureMode.photo),
          videoPathBuilder: () =>
              ref.read(cameraControllerProvider).path(CaptureMode.video),
          initialCaptureMode: CaptureMode.photo,
        ),
      ),
    ));
  }
}
