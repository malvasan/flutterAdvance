import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/data/retrieve_images/firebase_images.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera.dart';
import 'package:wisy_mobile_challenge/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

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
        body: ref.watch(firebaseImage).when(
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
          // Text.rich(
          //   TextSpan(
          //       text: 'The url where the photo is hosted at ',
          //       style: const TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 10.0,
          //       ),
          //       children: <TextSpan>[
          //         TextSpan(
          //           text: '"${image.url ?? 'not url'}"',
          //           style: const TextStyle(
          //               fontSize: 10.0, fontWeight: FontWeight.normal),
          //         )
          //       ]),
          // ),
          if (image.url != null)
            AspectRatio(aspectRatio: 2.0, child: Image.network(image.url!)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text.rich(
            TextSpan(
                text: 'Orientation: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '"${image.orientation ?? ''}"',
                    style: const TextStyle(
                        fontSize: 10.0, fontWeight: FontWeight.normal),
                  )
                ]),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text.rich(
            TextSpan(
                text: 'Latitude: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '"${image.latitude ?? '[0, 0, 0]'}"',
                    style: const TextStyle(
                        fontSize: 10.0, fontWeight: FontWeight.normal),
                  )
                ]),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text.rich(
            TextSpan(
                text: 'Longitude: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '"${image.longitude ?? '[0, 0, 0]'}"',
                    style: const TextStyle(
                        fontSize: 10.0, fontWeight: FontWeight.normal),
                  )
                ]),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
        ],
      ),
    );
  }
}
