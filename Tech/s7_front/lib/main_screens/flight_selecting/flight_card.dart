import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s7_front/colors/colors.dart';

import '../../api/back_flight.swagger.dart';


class FlightCard extends StatelessWidget {
  final FlightBase flight;
  final Function? onTap;

  const FlightCard({super.key, required this.flight, this.onTap});

  String getDate(DateTime date) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);
    return formattedDate;
  }

  String getTime(DateTime date) {
    String formattedTime = DateFormat('HH:mm').format(date);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!(flight);
            }
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  height: 150,
                  imageUrl: "flight",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.airplanemode_active_sharp, color: S7Color.bitterLemon.value,),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(flight.icao24.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, )),
                      Divider(color: S7Color.bitterLemon.value),
                      SizedBox(height: 8),
                      Text("Date: ${getDate(DateTime.now())}"),
                      Text("Arrival: ${flight.arrivalPlace?? "-"}"),
                      Text("Departure: ${flight.departurePlace?? "-"}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
