/* This is free and unencumbered software released into the public domain. */

import 'package:flutter/material.dart';
import 'package:xetia_model_viewer/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ModelViewerController? _controller;
  String? _selectedMaterial;
  String? _selectedVariant;

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
                minRenderScale: 1,
                backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src: 'assets/single_3D.glb', // a bundled asset file
                iosSrc:
                    'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                alt: "A 3D model of an astronaut",
                ar: true,
                arModes: ['scene-viewer', 'webxr', 'quick-look'],
                autoRotate: true,
                cameraControls: true,
                id: 'model',

                onCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                onLoading: (progress) {
                  print(progress);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: _selectedVariant,
                  onChanged: (value) {
                    setState(() {
                      _selectedVariant = value;
                      _controller?.setVariant(value);
                    });
                  },
                  items: _controller?.variants.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList() ??
                      [],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedMaterial,
                        onChanged: (value) {
                          setState(() {
                            _selectedMaterial = value;
                          });
                        },
                        items: _controller?.materials.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller?.changeColor(
                          _selectedMaterial!,
                          Colors.red,
                        );
                      },
                      child: Text('RED'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller?.changeColor(
                          _selectedMaterial!,
                          Colors.green,
                        );
                      },
                      child: Text('GREEN'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller?.changeColor(
                          _selectedMaterial!,
                          Colors.blue,
                        );
                      },
                      child: Text('BLUE'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
