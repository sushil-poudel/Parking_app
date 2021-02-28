import 'package:flutter/material.dart';
// import 'package:maps_parking/screens/mainscreen.dart';
import 'package:provider/provider.dart';
// import 'models/place.dart';
import 'package:maps_parking/homepage.dart';
 import 'package:maps_parking/parking_expense/parking_expenses.dart';
import'package:maps_parking/screens/auth_screen.dart';
import'package:maps_parking/screens/login.dart';
import'package:maps_parking/screens/registration.dart';
import'package:maps_parking/services/auth.dart';
import 'package:maps_parking/screens/homescreen.dart';
import 'package:maps_parking/screens/register.dart';
import 'package:maps_parking/screens/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(

        title: 'Login App',

        theme: ThemeData(
          primaryColor: Colors.blue,
        ),

        home: SignupScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),
          HomeScreen.routeName: (ctx)=> HomeScreen(),
          PersonalExpenses.routeName: (ctx)=> PersonalExpenses(),
          HomePage.routeName: (ctx)=> HomePage(),
          About.routeName: (ctx)=> About(),
        },
      ),
    );
  }
}