import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/providers.dart';

import 'package:flutter_tennis_court/screens/screens.dart';

import 'package:flutter_tennis_court/theme/custom_theme.dart';

void main() => runApp(const MyProvider());

class MyProvider extends StatelessWidget {
  const MyProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => BookingsProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final bookingsProvider =
        Provider.of<BookingsProvider>(context, listen: false);

    return MaterialApp(
      scaffoldMessengerKey: bookingsProvider.scaffoldKey,
      title: 'Tennis court app',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.customTheme,
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/home': (context) => const HomeScreen(),
        '/court-detail': (context) => const CourtDetailScreen(),
      },
    );
  }
}
