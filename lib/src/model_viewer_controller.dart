import 'dart:ui';

abstract class ModelViewerController {
  Future<void> changeColor(String materialName, Color color);
  Future<void> setVariant(String? variant);
  List<String> get materials;
  List<String> get variants;
}
