import 'package:flutter/material.dart';
import 'package:widget_common/presentation/feature/home/page/home_page.dart';

import 'core/utils/constants/app_strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

