import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppSpinKitTheme {
  AppSpinKitTheme._();

  static const double size = 50.0;

  static final lightSpinKit = const SpinKitCircle(
    color: Colors.black,
    size: size,
  );

  static final darkSpinKit = const SpinKitCircle(
    color: Colors.white,
    size: size,
  );
}
