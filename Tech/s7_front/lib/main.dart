import 'package:flutter/material.dart';
import 'package:s7_front/api/back_flight.swagger.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:s7_front/main_screens/flight_selecting/flights.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: S7Color.bitterLemon.value),
        useMaterial3: true,
      ),
      home: const FlightsScreen(),
    );
  }
}
