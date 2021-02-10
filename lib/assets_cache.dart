import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

class AssetsCache {
  static List<String> _imagesUri = ["sun.png"];
  static Map<String, ui.Image> _images = {};

  static Future<bool> load() async {
    await _loadImages(_imagesUri);
    print("assets loaded successfully");
    return true;
  }

  static ui.Image getImage(uri) {
    return _images[uri];
  }

  static Future _loadImages(List<String> imagesUri) async {
    List<Future> futures = [];
    imagesUri.forEach((uri) {
      futures.add(_getUiImage(uri).then((uiImage) {
        _images[uri] = uiImage;
      }));
    });
    await Future.wait(futures);
  }

  static Future<ui.Image> _getUiImage(String imageAssetPath) async {
    final ByteData assetImageByteData =
        await rootBundle.load("assets/images/" + imageAssetPath);
    image.Image baseSizeImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(baseSizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
