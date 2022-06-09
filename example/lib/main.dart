/* This is free and unencumbered software released into the public domain. */

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

const relatedJs = '''
  function updateColorRGBA(colorString) {
    if (!colorString) {
      return;
    }

    const color = colorString.substring(5, colorString.length - 1)
      .replace(/ /g, '')
      .split(',')
      .map(numberString => parseFloat(numberString));

    updateColor(color);
  }

  function updateColor(color) {
    const modelViewerColor = document.querySelector("model-viewer#model");

    const [material] = modelViewerColor.model.materials;
    material.pbrMetallicRoughness.setBaseColorFactor(color);
  }
''';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ModelViewerController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ModelViewer(
                backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src:
                    'https://raw.githubusercontent.com/omchiii/model_viewer_plus.dart/master/example/assets/Astronaut.glb', // a bundled asset file
                iosSrc:
                    'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                alt: "A 3D model of an astronaut",
                ar: true,
                arModes: ['scene-viewer', 'webxr', 'quick-look'],
                autoRotate: true,
                cameraControls: true,
                id: 'model',
                relatedJs: relatedJs,
                onCreated: (controller) {
                  _controller = controller;
                },
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller
                        .runJavascript('updateColorRGBA', ['rgba(1,0,0,1)']);
                  },
                  child: Text('RED'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller
                        .runJavascript('updateColorRGBA', ['rgba(0,1,0,1)']);
                  },
                  child: Text('GREEN'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller
                        .runJavascript('updateColorRGBA', ['rgba(0,0,1,1)']);
                  },
                  child: Text('BLUE'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
