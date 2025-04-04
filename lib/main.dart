import 'package:butterflix/splash/controller/splash_controller.dart';
import 'package:butterflix/utils/common_utilities.dart';
import 'package:butterflix/utils/routers.dart';
import 'package:butterflix/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        // builder: EasyLoading.init(),
        builder: FToastBuilder(),
        title: "ButterFlix",

        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,

        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalVariable.navState,

        initialRoute: AppScreen.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
