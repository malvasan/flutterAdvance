import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/auth.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/auth_controller.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/images_list_controller.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/sign_in.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera_controller.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authenticationStateProvider);

    return authStateAsync.when(
        data: (user) => user != null ? ImagesPresentationPage() : LoginPage(),
        error: (err, stack) => Text('Error: $err'),
        loading: () => loadingWidget);
  }
}

class ImagesPresentationPage extends ConsumerWidget {
  const ImagesPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(cameraControllerProvider, (_, state) {
      var snackBarMessage = '';
      switch (state) {
        case AsyncData _:
          snackBarMessage = 'uploaded';
          break;
        case AsyncLoading _:
          snackBarMessage = 'is uploading';
          break;
        case AsyncError _:
          snackBarMessage = 'not uploaded';
          break;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image $snackBarMessage")));
    });

    return ImagesList();
  }
}

class ImagesList extends ConsumerWidget {
  const ImagesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ref.watch(firebaseImageProvider).when(
            loading: () => loadingWidget,
            error: (error, stackTrace) => Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () =>
                              ref.invalidate(firebaseImageProvider),
                          child: Text(error.toString()))
                    ],
                  ),
                ),
            data: (images) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Camera()),
                          );
                        },
                        child: const Text('Take Photo'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(firebaseAuthenticationProvider)
                              .instance
                              .signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: images.length,
                        itemBuilder: (BuildContext content, int index) {
                          return ImagesUploaded(
                            image: images[index],
                          );
                        }),
                  )
                ],
              );
            }));
  }
}

class ImagesUploaded extends StatefulWidget {
  const ImagesUploaded({
    super.key,
    required this.image,
  });

  final ImageFirebase image;

  @override
  State<ImagesUploaded> createState() => _ImagesUploadedState();
}

class _ImagesUploadedState extends State<ImagesUploaded> {
  var showImage = false;
  var imageSelected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The photo was taken at ${DateTime.fromMicrosecondsSinceEpoch(widget.image.timestamp.microsecondsSinceEpoch)}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageAttributes(
                      name: 'Orientation',
                      value: widget.image.orientation,
                      nullValue: '',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                    ),
                    ImageAttributes(
                      name: 'Latitude',
                      value: widget.image.latitude,
                      nullValue: '[0, 0, 0]',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                    ),
                    ImageAttributes(
                      name: 'Longitude',
                      value: widget.image.longitude,
                      nullValue: '[0, 0, 0]',
                    ),
                  ],
                ),
              ),
              if (widget.image.url != null)
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: InteractiveViewer(
                                  panEnabled: false,
                                  boundaryMargin: EdgeInsets.all(80),
                                  minScale: 0.5,
                                  maxScale: 2,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.network(
                                      widget.image.url!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.network(
                        widget.image.url!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
          ),
        ],
      ),
    );
  }
}

// OverlayPortal(
//                         controller: _imageSelectedController,
//                         child: AspectRatio(
//                           aspectRatio: 1.0,
//                           child: Image.network(
//                             widget.image.url!,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         overlayChildBuilder: (context) {
//                           return Center(
//                             child: AspectRatio(
//                               aspectRatio: 1.0,
//                               child: Image.network(
//                                 widget.image.url!,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           );
//                         }),

class ImageAttributes extends StatelessWidget {
  const ImageAttributes({
    super.key,
    required this.name,
    required this.value,
    required this.nullValue,
  });

  final String name;
  final String? value;
  final String nullValue;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: '$name: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '"${value ?? nullValue}"',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
            )
          ]),
    );
  }
}
