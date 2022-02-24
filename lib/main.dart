import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neosoft/utility/theme.dart';
import 'package:neosoft/view/screens/home_page.dart';
import 'package:neosoft/view_model/register_viewmodel.dart';
import 'package:provider/provider.dart';

import 'container/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Registration',
        theme: ThemeData(
          primaryColor: primaryColor,
          splashColor: primaryColor,
          accentColor: primaryColor,
          shadowColor: primaryColor,
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: ChangeNotifierProvider(
          child: HomePage(),
          create: (ctx) => RegisterViewModel(serviceLocater()),
        ));
  }
}
