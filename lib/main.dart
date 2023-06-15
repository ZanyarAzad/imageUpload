import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  Future getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemprorary = File(image.path);

    setState(() {
      this._image = imageTemprorary;
    });
  }
  Future getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemprorary = File(image.path);

    setState(() {
      this._image = imageTemprorary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                  )
                : Image.network(
                    'https://cdn.thewirecutter.com/wp-content/media/2022/07/laptop-under-500-2048px-acer-1.jpg'),
            SizedBox(
              height: 40,
            ),
            CustomButton(
                title: "pickImageGallery",
                iconData: Icons.image,
                onClick: getImageGallery),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                title: "pickImageCamera",
                iconData: Icons.camera_alt,
                onClick: getImageCamera),
          ],
        ),
      ),
    );
  }

  Widget CustomButton(
      {required String title,
      required IconData iconData,
      required VoidCallback onClick}) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [Icon(iconData), Text(title)],
        ),
      ),
    );
  }
}
