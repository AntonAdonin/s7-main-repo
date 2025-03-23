import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:s7_front/data_provider/flights_provider.dart';
import 'package:s7_front/notifications/notification.dart';

import '../../api/back_flight.swagger.dart';

class DetailedLandmarkScreen extends StatefulWidget {
  final Poi landmark;
  final PoiDetail detailed;
  final String icao24;

  const DetailedLandmarkScreen({Key? key, required this.landmark, required this.detailed, required this.icao24})
    : super(key: key);

  @override
  _LandmarkScreenState createState() => _LandmarkScreenState();
}

class _LandmarkScreenState extends State<DetailedLandmarkScreen> {
  FlightsProvider flightsProvider = FlightsProvider();
  String? summarizedText;
  bool isSummarizing = false;
  String fetchedText = "";

  Future<void> _fetchSummary() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
      },
    );

    try {
      fetchedText = await flightsProvider.getSummarization(widget.icao24, widget.landmark.id!);
      print(fetchedText);
    } catch (e) {
      print(e);
      Navigator.pop(context);
      showError(context, "something went wrong");
      return;
    }

    Navigator.pop(context);

    setState(() {
      isSummarizing = true;
      summarizedText = "";
    });

    for (int i = 0; i < fetchedText.length; i++) {
      await Future.delayed(Duration(milliseconds: 35));
      setState(() {
        summarizedText = fetchedText.substring(0, i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.landmark.name ?? 'Point of Interest',
          style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
        ),
        backgroundColor: S7Color.bitterLemon.value,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                errorWidget: (context, _, __) => Icon(Icons.location_city, size: 80, color: S7Color.white.value),
                imageUrl: widget.landmark.imageUrl ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            if (summarizedText == null) ...[
              Center(
                child: ElevatedButton(
                  onPressed: _fetchSummary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/ai_icon.png', height: 24),
                      const SizedBox(width: 12),
                      const Text('AI summarize', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${widget.landmark.type}",
                  style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              _buildSectionTitle('Description'),
              Text(
                widget.landmark.description ?? 'No Description',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              _buildDynamicSection('Details', widget.detailed.details),
              _buildDynamicSection('Tags', widget.detailed.tags),
              SizedBox(height: 16),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(summarizedText!, style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
              Center(child: backUpButton()),
              SizedBox(height: 16),
            ],
            _buildMap(),
          ],
        ),
      ),
    );
  }

  Widget backUpButton() {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          summarizedText = null;
        });
      },
      child: Text("вернуть данные"),
    );
  }

  Widget _buildMap() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(center: LatLng(widget.detailed.lat, widget.detailed.lon), zoom: 15.0),
          children: [
            TileLayer(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(widget.detailed.lat ?? 0, widget.detailed.lon ?? 0),
                  child: Icon(Icons.location_on, color: Colors.red, size: 40.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: GoogleFonts.robotoSlab(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget _buildDynamicSection(String title, dynamic data) {
    if (data == null || data.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: S7Color.bitterLemon.value),
          _buildSectionTitle(title),
          SizedBox(height: 4),
          if (data is Map)
            ...data.entries.map((entry) => _buildInfoRow(entry.key, entry.value))
          else if (data is List)
            ...data.map((item) => _buildInfoRow("•", item))
          else
            SizedBox(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String key, String value) {
    key = key.split(':').join(' ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (key.isNotEmpty) Text("$key: ", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value, style: GoogleFonts.openSans(fontSize: 16))),
        ],
      ),
    );
  }
}
