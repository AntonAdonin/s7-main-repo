import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:s7_front/data_provider/flights_provider.dart';
import 'package:s7_front/notifications/notification.dart';

import '../business_objects/flight.dart';

class FlightSearchScreen extends StatefulWidget {
  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  String searchQuery = "";

  Widget searchWidget() {
    return TextField(

      decoration: InputDecoration(

        filled: true,
        fillColor: S7Color.white.value,
        // Белый фон поля ввода
        labelText: 'номер рейса',
        labelStyle: TextStyle(color: S7Color.sonicSilver.value, fontSize: 20),
        // Чёрный текст метки
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Закруглённые углы
          borderSide: BorderSide(color: S7Color.bitterLemon.value),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.black), // Иконка поиска
      ),
      onChanged: onChanged,
    );
  }

  Widget submitButton(onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: S7Color.bitterLemon.value,
          foregroundColor: S7Color.white.value,
        ),
        child: const Text("найти", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  onChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  onSubmit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Object? error;
    Flight? flight;
    await FlightsProvider()
        .getFlight(searchQuery)
        .then((val) {
          flight = val;
        })
        .onError((err, stackTrace) {
          error = err;
        });


    Navigator.pop(context);

    if (!context.mounted) {
      return;
    }

    if (error != null) {
      showError(context, "Something went wrong");
      log("ERROR: ${error}");
      return;
    }

    if (flight == null) {
      showError(context, "Flight not found");
      return;
    }

    showSuccess(context, "Flight found");
    Navigator.pop(context, flight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Flights"), backgroundColor: S7Color.bitterLemon.value),
      backgroundColor: S7Color.sonicSilver.value,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24), // Увеличил отступы
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Размещение по центру
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [searchWidget(), SizedBox(height: 16), submitButton(onSubmit)],
          ),
        ),
      ),
    );
  }
}
