import 'package:app/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dependency_injection.dart' as di;

Future configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SCAFFOLD_BACKGROUND_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
