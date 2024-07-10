import 'package:flutter/material.dart';
import 'package:project/pages/register_page.dart';
import 'package:provider/provider.dart';
import '../classes/theme_notifire.dart';
import '../classes/search_provider.dart';
import 'methods/shared_preferences.dart';
import 'pages/home_page.dart';

void main() async{
  // Initialize SharedPreferences before runApp
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.currentTheme, // Use the current theme here
            home: RegistrationPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}
