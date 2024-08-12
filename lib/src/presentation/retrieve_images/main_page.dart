import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/main_page_controller.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ref.watch(firebaseImageProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
            data: (images) {
              return Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // ref.read(selectedPageNameProvider.state).state =
                        //     'Second Page';
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Camera()));
                      },
                      child: const Text('Take Photo'),
                    ),
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

class ImagesUploaded extends StatelessWidget {
  const ImagesUploaded({
    super.key,
    required this.image,
  });

  final ImageFirebase image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(4),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The photo was taken at ${DateTime.fromMicrosecondsSinceEpoch(image.timestamp.microsecondsSinceEpoch)}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          if (image.url != null)
            AspectRatio(aspectRatio: 2.0, child: Image.network(image.url!)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          ImageAttributes(
              name: 'Orientation', value: image.orientation, nullValue: ''),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          ImageAttributes(
              name: 'Latitude', value: image.latitude, nullValue: '[0, 0, 0]'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          ImageAttributes(
              name: 'Longitude',
              value: image.longitude,
              nullValue: '[0, 0, 0]'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
        ],
      ),
    );
  }
}

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
            fontSize: 10.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '"${value ?? nullValue}"',
              style: const TextStyle(
                  fontSize: 10.0, fontWeight: FontWeight.normal),
            )
          ]),
    );
  }
}
