import 'dart:ui';

abstract class ModelViewerController {
  Future<void> changeColor(String materialName, Color color);
  List<String> get materials;
}
