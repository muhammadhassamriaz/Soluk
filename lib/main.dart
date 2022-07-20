import 'package:app/module/influencer/workout/hive/local/my_hive.dart';
import 'package:app/utils/shared_preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './utils/configure_app.dart' as ca;
import 'module/influencer/multi_bloc_provider.dart';

void main() async {
  await Hive.initFlutter();
  await MyHive.init();
  await PreferenceManager.instance.init();
  await ca.configureApp();
  runApp(const InitialiseBlocs());
}
