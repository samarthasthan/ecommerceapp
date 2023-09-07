import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

changeStatusBarColor(color) async {
  await FlutterStatusbarcolor.setStatusBarColor(color);
  if (useWhiteForeground(color)) {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

  await FlutterStatusbarcolor.setNavigationBarColor(color);
  if (useWhiteForeground(color)) {
    await FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  } else {
    await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }
}
