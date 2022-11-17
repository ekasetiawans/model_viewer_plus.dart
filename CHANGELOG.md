## 1.3.0

 - **FIX**: added minRenderScale.
 - **FIX**: web onLoading.
 - **FIX**: webview background color.
 - **FIX**: poster color.
 - **FIX**: element id.
 - **FIX**: js.
 - **FIX**: function name.
 - **FIX**: element view.
 - **FIX**: variable name.
 - **FIX**: js function name.
 - **FIX**: unique js variable name.
 - **FEAT**: replace default progressbar when onLoading is handled.
 - **FEAT**: added minRenderScale.
 - **FEAT**: support change variant.
 - **FEAT**: added onLoading progress.
 - **FEAT**: using transparent when posterColor.alpha is zero.
 - **FEAT**: added --poster-color css.
 - **FEAT**: update js function name.
 - **FEAT**: improve model viewer controller.
 - **FEAT**: fix web script.
 - **FEAT**: added ModelViewerController.

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0]

### Added

- More examples in `example/lib`

### Changed

- `lib\html_builder.dart`, `lib\model_viewer_plus_mobile.dart`, `lib\model_viewer_plus_web.dart`, `lib\model_viewer_plus.dart`: implement all the attributes of `<model-viewer>` v1.11.1.
- ModelViewer.arSacle from `final String? arScale` to `final ArScale? arScale`, which may be a breaking change.
- Update `assets/model-viewer.min.js` to v1.11.1
- Update example dir's gradle version to 7.0.2

## [1.1.5] - 2022-03-15

### Changed

- `lib/src/model_viewer_plus_mobile.dart`
  - Fix [#11](https://github.com/omchiii/model_viewer_plus.dart/issues/11), add `gestureRecognizers`
  - A less elegant solution of [#8](https://github.com/omchiii/model_viewer_plus.dart/issues/8), open usdz file by [url_launcher](https://pub.dev/packages/url_launcher) in SFSafariViewController.

## [1.1.4] - 2022-03-14

### Changed

- `/lib/src/model_viewer_plus_mobile.dart`, update according to the [newest document](https://developers.google.com/ar/develop/scene-viewer#3d-or-ar). Fix [#9](https://github.com/omchiii/model_viewer_plus.dart/issues/9).
  - Insted of `com.google.ar.core`, now we use `com.google.android.googlequicksearchbox`. This should support the widest possible range of devices.
  - Mode defaults to `ar_preferred`. Scene Viewer launches in AR native mode as the entry mode. If Google Play Services for AR isn't present, Scene Viewer gracefully falls back to 3D mode as the entry mode.
- Add `arModes` to example, closer to [modelviewer.dev](https://modelviewer.dev)'s offical example.
- Update `example\android\app\build.gradle` `compileSdkVersion` to 31
- Update `android_intent_plus` to `3.1.1`
- Update `webview_flutter` to `3.0.1`

### Removed

- `/lib/src/http_proxy.dart`: empty file

## [1.1.3] - 2022-03-14

### Changed

- `ModelViewer`'s default `backgroundColor` from `Colors.white` to `Colors.transparent`, due to [#12](https://github.com/omchiii/model_viewer_plus.dart/issues/12)
- `proxy`'s null check fix and `setState() {}` for it, due to [#10](https://github.com/omchiii/model_viewer_plus.dart/issues/10)

## [1.1.2] - 2022-02-17

### Added

- `/lib/src/shim/` with `dart_html_fake.dart` and `dart_ui_fake.dart`. Fixing `ERROR: The name platformViewRegistry' is being referenced through the prefix 'ui', but it isn't defined in any of the libraries imported using that prefix.` and `INFO: Avoid using web-only libraries outside Flutter web plugin` to improve the [score on pub.dev](https://pub.dev/packages/model_viewer_plus/score).

### Changed

- example's `/etc/assets` -> `/assets`

## [1.1.1] - 2022-02-17

### Added

- `/assets/model-viewer.min.js` (v1.10.1, which is actually identical to v1.10.0)

### Changed

- `/etc/assets` -> `/assets`
- `example/flutter_02.png`: Updated the Screenshot.
- `README.md`: README Update.
- `lib/src/model_viewer_plus_web.dart`: Due to the change of `model-viewer.js` -> `model-viewer.min.js`
- `lib/src/model_viewer_plus_mobile.dart`: Due to the change of `model-viewer.js` -> `model-viewer.min.js`, added CircularProgressIndicator while mobile platform loading

### Removed

- `/etc/assets/model-viewer.js`: To slim the package size.

## [1.1.0] - 2022-02-15

### Added

- Web Support
  - `lib/src/model_viewer_plus_stub.dart`
  - `lib/src/model_viewer_plus_mobile.dart`
  - `lib/src/model_viewer_plus_web.dart`

### Changed

- `lib/model_viewer_plus.dart`
- `lib/src/model_viewer_plus.dart`
