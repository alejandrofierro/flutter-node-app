import 'package:flutter/material.dart';
import 'package:flutter_contacts/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/screens/screens.dart';
import 'package:flutter_contacts/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CustomerService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',
      initialRoute: '/auth',
      routes: {
        '/login': (_) => LoginScreen(),
        '/home': (_) => HomeScreen(),
        '/customer': (_) => CustomerScreen(),
        '/auth': (_) => CheckAuthScren()
      },
      scaffoldMessengerKey: NotifyService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(color: Colors.indigo)),
    );
  }
}
