import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc/app_bloc_observer.dart';
import 'app/bloc/bloc_di.dart';
import 'config/environment.dart';
import 'core/initializer/init_app.dart';
import 'core/network/my_http_overrides.dart';
import 'modules/dashboard/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  /// =============== App initialization ================
  await initApp(Environment.fromEnv(AppEnv.dev));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocDI(
      child: MaterialApp(
        title: 'Cp Confirm Location',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: DashboardPage(),
      ),
    );
  }
}
