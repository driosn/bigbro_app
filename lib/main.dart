import 'package:flutter/material.dart';
import 'package:mibigbro/screens/home/home.dart';
import 'package:mibigbro/screens/login/login.dart';
import 'package:mibigbro/screens/login/registro.dart';
import 'package:mibigbro/utils/storage.dart';
import 'screens/onboard/onboard1.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mibigbro',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', ''), // Spanish, no country code
      ],
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xff1A2461),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Manrope',
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Color(0xffEC1C24),
        ),
        primaryColor: Color(0xff1A2461),
        colorScheme: ColorScheme(
          secondary: Color(0xffEC1C24),
          brightness: Brightness.light,
          background: Colors.white,
          error: Colors.red,
          onBackground: Theme.of(context).primaryColor,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Theme.of(context).primaryColor,
          primary: Theme.of(context).primaryColor,
          surface: Colors.white,
        ),
        accentColor: Color(0xffEC1C24),
        scaffoldBackgroundColor: Color(0xffFCFCFC),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xff1A2461),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
      initialRoute:
          (StorageUtils.getInteger("id_usuario") == 0) ? 'onboard1' : 'home',
      routes: {
        'home': (context) => Home(),
        'login': (context) => Login(),
        'registro': (context) => Registro(),
        'onboard1': (context) => Onboard1(),
      },
    );
  }
}
