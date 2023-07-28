import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notification_of_support/Service/ServiceNotification.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:notification_of_support/route/SignInScreen.dart';
import 'package:notification_of_support/route/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'model_provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
// * hereis the run notification FCM
  await ServiceNotification.initializeNotification();
// ! tocheck system theme

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orSize, deviceType) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: SplashScreen.ROUTE,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          navigatorKey: navigatorKey,
          routes: {
            HomeScreen.Route: (context) => const HomeScreen(),
            SignInScreen.Route: (context) =>  SignInScreen(),
            SplashScreen.ROUTE: (context) => const SplashScreen(),
          },
        );
      },
    );
  }
}
