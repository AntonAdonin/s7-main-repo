import 'package:flutter/cupertino.dart';
import 'package:s7_front/main_screens/flight_selecting/flight_card.dart';

import '../../api/back_flight.swagger.dart';


class FlightsList extends StatelessWidget {
  final List<FlightBase> flights;
  final Function? onTap;

  const FlightsList({super.key, required this.flights, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: flights.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FlightCard(flight: flights[index], onTap: onTap),
        );
      },
    );
  }


}

