import 'package:flutter/material.dart';
import 'package:xetia_model_viewer/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String css = '''
model-viewer#reveal {
  --poster-color: transparent;
}
''';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Model Viewer")),
          body: ModelViewer(
            id: "revea",
            loading: Loading.eager,
            cameraControls: true,
            autoRotate: true,
            poster: "https://modelviewer.dev/assets/poster-shishkebab.png",
            src: "https://modelviewer.dev/shared-assets/models/shishkebab.glb",
            alt: "A 3D model of a shishkebab",
            relatedCss: css,
          )),
    );
  }
}
