import 'dart:io';

import 'package:wedding/repositories.dart';

class CheckinViewModel extends ViewModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  Barcode? get result => _result;
  set result(Barcode? value) {
    _result = value;
    notifyListeners();
  }

  QRViewController? controller;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
    });
  }

  @override
  void init() {}

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {
    controller?.dispose();
  }

  @override
  void onUnmount() {
    controller?.dispose();
  }

  @override
  void onResume() {}

  @override
  void onPause() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void onInactive() {
    controller?.dispose();
  }

  @override
  void onDetach() {}
}
