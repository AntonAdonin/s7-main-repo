import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:s7_front/data_provider/flights_provider.dart';
import 'package:s7_front/main_screens/flight_search.dart';
import 'package:s7_front/main_screens/flight_selecting/flights_list.dart';
import 'package:s7_front/main_screens/landmarks/landmarks.dart';

import '../../api/back_flight.swagger.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  FlightsProvider flightsProvider = FlightsProvider();
  List<FlightBase> flights = [];
  late Future<List<FlightBase>> futureFlights;

  @override
  void initState() {
    super.initState();
    updateFlights();
  }

  void updateFlights() {
    setState(() {
      futureFlights = flightsProvider.getFlights();
      futureFlights.then((val) {
        setState(() {
          flights = val;
        });
      });
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 300));
    updateFlights();
  }

  Widget listFutureBuilder(context) {
    return FutureBuilder<List<FlightBase>>(
      future: futureFlights,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return FlightsList(
          flights: flights,
          onTap: (flight) {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => LandmarksScreen(flight: flight)));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flights"),
        backgroundColor: S7Color.bitterLemon.value,
      ),
      backgroundColor: S7Color.sonicSilver.value,
      body: RefreshIndicator(onRefresh: _refreshData, child: listFutureBuilder(context)),
    );
  }
}
