import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ünlü Fotoğrafları',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _images = [
    'https://tr.web.img3.acsta.net/c_310_420/pictures/202/447/20244728_20130917114825223.jpg',
    'https://tr.web.img4.acsta.net/pictures/17/11/06/09/53/0748489.jpg',
    'https://tr.web.img3.acsta.net/c_310_420/pictures/210/127/21012705_2013061512270994.jpg',
    'https://tr.web.img3.acsta.net/pictures/16/09/22/14/21/123441.jpg',
    'https://tr.web.img2.acsta.net/r_1280_720/pictures/24/02/19/10/09/4922756.jpg',
   
  ];

  final List<String> _likedImages = [];
  final List<String> _dislikedImages = [];
  late String _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = _getRandomImage();
  }

  String _getRandomImage() {
    final random = Random();
    return _images[random.nextInt(_images.length)];
  }

  void _likeImage() {
    setState(() {
      _likedImages.add(_currentImage);
      _currentImage = _getRandomImage();
    });
  }

  void _dislikeImage() {
    setState(() {
      _dislikedImages.add(_currentImage);
      _currentImage = _getRandomImage();
    });
  }

  void _showLikedImages(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageListScreen(images: _likedImages, title: 'Beğenilenler'),
      ),
    );
  }

  void _showDislikedImages(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageListScreen(images: _dislikedImages, title:'Beğenilmeyenler'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ünlü Fotoğrafları'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: unnecessary_null_comparison
            if (_currentImage != null)
              Image.network(_currentImage),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _likeImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Beğen'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _dislikeImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Beğenme'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () => _showLikedImages(context),
              backgroundColor: Colors.red,
              child: const Icon(Icons.thumb_up),
            ),
            FloatingActionButton(
              onPressed: () => _showDislikedImages(context),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.thumb_down),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageListScreen extends StatelessWidget {
  final List<String> images;
  final String title;

  const ImageListScreen({super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(images[index]),
          );
        },
      ),
    );
  }
}
