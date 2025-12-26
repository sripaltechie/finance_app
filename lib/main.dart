import 'package:chanda_finance/utils/routes.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view/navbar_view.dart';
import 'package:chanda_finance/view_model/auth_view_model.dart';
import 'package:chanda_finance/view_model/collector_amount_view_model.dart';
import 'package:chanda_finance/view_model/drcr_view_model.dart';
import 'package:chanda_finance/view_model/theme_changer_view_model.dart';
import 'package:chanda_finance/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:terrace_cricket/view/home_view.dart';
// import 'package:terrace_cricket/view/login_view.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const NavBar(),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
            ChangeNotifierProvider(create: (_) => UserViewModel()),
            ChangeNotifierProvider(create: (_) => ThemeChanger()),
            ChangeNotifierProvider(create: (_) => Collector_Amount_ViewModel()),
            ChangeNotifierProvider(create: (_) => DrcrViewModel()),
          ],
          child: Builder(builder: (BuildContext context) {
            final themeChanger = Provider.of<ThemeChanger>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: themeChanger.themeMode,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue,
                  appBarTheme: const AppBarTheme(backgroundColor: Colors.blue)),
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
            );
          }),
        ));
  }
}
