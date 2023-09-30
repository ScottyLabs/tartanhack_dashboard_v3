import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tartanhacks_dashboard_v3/pages/login.dart';
import 'package:tartanhacks_dashboard_v3/themes/theme.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeChanger(darkTheme))
    ],
    child: const MyApp()
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.getTheme,
      home: Login(),
    );
  }
}
