/* This is free and unencumbered software released into the public domain. */

// ignore_for_file: undefined_prefixed_name

import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:model_viewer_plus/src/model_viewer_controller.dart';

import 'html_builder.dart';
import 'model_viewer_plus.dart';

class ModelViewerState extends State<ModelViewer> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    generateModelViewerHtml();
  }

  /// To generate the HTML code for using the model viewer.
  void generateModelViewerHtml() async {
    final htmlTemplate = await rootBundle
        .loadString('packages/model_viewer_plus/assets/template.html');
    // allow to use elements
    final NodeValidator _validator = NodeValidatorBuilder.common()
      ..allowElement('meta',
          attributes: ['name', 'content'], uriPolicy: _AllowUriPolicy())
      ..allowElement('style')
      ..allowElement('script',
          attributes: ['src', 'type', 'defer'], uriPolicy: _AllowUriPolicy())
      ..allowCustomElement('model-viewer',
          attributes: [
            'style',

            // Loading Attributes
            'src',
            'alt',
            'poster',
            'seamless-poster',
            'loading',
            'reveal',
            'with-credentials',

            // Augmented Reality Attributes
            'ar',
            'ar-modes',
            'ar-scale',
            'ar-placement',
            'ios-src',
            'xr-environment',

            // Staing & Cameras Attributes
            'camera-controls',
            'enable-pan',
            'touch-action',
            'disable-zoom',
            'orbit-sensitivity',
            'auto-rotate',
            'auto-rotate-delay',
            'rotation-per-second',
            'interaction-policy',
            'interaction-prompt',
            'interaction-prompt-style',
            'interaction-prompt-threshold',
            'camera-orbit',
            'camera-target',
            'field-of-view',
            'max-camera-orbit',
            'min-camera-orbit',
            'max-field-of-view',
            'min-field-of-view',
            'bounds',
            'interpolation-decay',

            // Lighting & Env Attributes
            'skybox-image',
            'environment-image',
            'exposure',
            'shadow-intensity',
            'shadow-softness ',

            // Animation Attributes
            'animation-name',
            'animation-crossfade-duration',
            'autoplay',

            // Scene Graph Attributes
            'variant-name',
            'orientation',
            'scale',
          ],
          uriPolicy: _AllowUriPolicy());

    ui.platformViewRegistry.registerViewFactory(
      'model-viewer-html',
      (int viewId) => HtmlHtmlElement()
        ..style.border = 'none'
        ..style.height = '100%'
        ..style.width = '100%'
        ..setInnerHtml(
          _buildHTML(htmlTemplate, viewId.toString()),
          validator: _validator,
        ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(final ModelViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO
  }

  @override
  Widget build(final BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
            semanticsLabel: 'Loading Model Viewer...',
          ))
        : HtmlElementView(
            viewType: 'model-viewer-html',
            onPlatformViewCreated: (id) {
              final modelViewer =
                  window.document.getElementById('${widget.id}-$id');
              if (modelViewer == null) return;

              modelViewer.addEventListener(
                'load',
                (event) {
                  final result =
                      js.context.callMethod('getMaterials_$_jsVarName');
                  final materials = (json.decode(result) as List)
                      .cast<String>()
                      .toSet()
                      .toList();

                  widget.onCreated?.call(_ModelViewerController(
                      materials: materials, varName: _jsVarName));
                },
              );
            },
          );
  }

  String _buildHTML(final String htmlTemplate, String viewId) {
    if (widget.src.startsWith('file://')) {
      // Local file URL can't be used in Flutter web.
      debugPrint("file:// URL scheme can't be used in Flutter web.");
      throw ArgumentError("file:// URL scheme can't be used in Flutter web.");
    }

    return HTMLBuilder.build(
      htmlTemplate: htmlTemplate.replaceFirst(
          '<script type="module" src="model-viewer.min.js" defer></script>',
          ''),
      // Attributes
      src: widget.src,
      alt: widget.alt,
      poster: widget.poster,
      seamlessPoster: widget.seamlessPoster,
      loading: widget.loading,
      reveal: widget.reveal,
      withCredentials: widget.withCredentials,
      // AR Attributes
      ar: widget.ar,
      arModes: widget.arModes,
      arScale: widget.arScale,
      arPlacement: widget.arPlacement,
      iosSrc: widget.iosSrc,
      xrEnvironment: widget.xrEnvironment,
      // Staing & Cameras Attributes
      cameraControls: widget.cameraControls,
      enablePan: widget.enablePan,
      touchAction: widget.touchAction,
      disableZoom: widget.disableZoom,
      orbitSensitivity: widget.orbitSensitivity,
      autoRotate: widget.autoRotate,
      autoRotateDelay: widget.autoRotateDelay,
      rotationPerSecond: widget.rotationPerSecond,
      interactionPolicy: widget.interactionPolicy,
      interactionPrompt: widget.interactionPrompt,
      interactionPromptStyle: widget.interactionPromptStyle,
      interactionPromptThreshold: widget.interactionPromptThreshold,
      cameraOrbit: widget.cameraOrbit,
      cameraTarget: widget.cameraTarget,
      fieldOfView: widget.fieldOfView,
      maxCameraOrbit: widget.maxCameraOrbit,
      minCameraOrbit: widget.minCameraOrbit,
      maxFieldOfView: widget.maxFieldOfView,
      minFieldOfView: widget.minFieldOfView,
      bounds: widget.bounds,
      interpolationDecay: widget.interpolationDecay,
      // Lighting & Env Attributes
      skyboxImage: widget.skyboxImage,
      environmentImage: widget.environmentImage,
      exposure: widget.exposure,
      shadowIntensity: widget.shadowIntensity,
      shadowSoftness: widget.shadowSoftness,
      // Animation Attributes
      animationName: widget.animationName,
      animationCrossfadeDuration: widget.animationCrossfadeDuration,
      autoPlay: widget.autoPlay,
      // Scene Graph Attributes
      variantName: widget.variantName,
      orientation: widget.orientation,
      scale: widget.scale,

      // CSS Styles
      backgroundColor: widget.backgroundColor,
      // Loading CSS
      posterColor: widget.posterColor,
      // Annotations CSS
      minHotspotOpacity: widget.minHotspotOpacity,
      maxHotspotOpacity: widget.maxHotspotOpacity,

      // Others
      innerModelViewerHtml: widget.innerModelViewerHtml,
      relatedCss: widget.relatedCss,
      relatedJs: _relatedJS(viewId),
      id: '${widget.id}-$viewId',
    );
  }

  final String _jsVarName = 'mv${DateTime.now().microsecondsSinceEpoch}';

  String _relatedJS(String viewId) {
    final varName = _jsVarName;

    return '''
  const $varName = document.querySelector("model-viewer#${widget.id}-$viewId");

  function updateMaterialColor_$varName(name, colorString) {
    const color = JSON.parse(colorString);
    const material = $varName.model.getMaterialByName(name);
    if (material){
      material.pbrMetallicRoughness.setBaseColorFactor(color);
    }
  }

  function getMaterials_$varName() {
    const materials = $varName.model.materials;
    const result = JSON.stringify(materials.map(material => material.name));
    return result;
  }

  ${widget.relatedJs}
''';
  }
}

class _AllowUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) {
    return true;
  }
}

class _ModelViewerController implements ModelViewerController {
  final String varName;

  @override
  final List<String> materials;

  _ModelViewerController({
    required this.materials,
    required this.varName,
  });

  @override
  Future<void> changeColor(String materialName, ui.Color color) async {
    final colors = <double>[
      color.red / 256,
      color.green / 256,
      color.blue / 256,
      color.alpha / 256,
    ];

    js.context.callMethod('updateMaterialColor_$varName', [
      materialName,
      json.encode(colors),
    ]);
  }
}
