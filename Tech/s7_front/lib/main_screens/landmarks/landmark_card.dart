import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/back_flight.swagger.dart';

class LandmarkCard extends StatelessWidget {
  final Poi landmark;
  final Function? onTap;

  const LandmarkCard({super.key, required this.landmark, this.onTap});

  Widget _linkAndTypeWidget() {
    return Row(
      children: [
        Icon(Icons.location_on, color: S7Color.bitterLemon.value),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              landmark.type ?? "-",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            InkWell(
              child: Text(
                landmark.website ?? "-",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                if (landmark.website != null) {
                  launchUrl(Uri.parse(landmark.website!));
                }
                // Open website
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  errorWidget: (context, _, _) {
                    return Icon(Icons.location_city, size: 80);
                  },
                  placeholder: (context, url) {
                    return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
                  },
                  imageUrl: landmark.imageUrl ?? "",
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        landmark.name ?? "-",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      Text(
                        landmark.description ?? "-",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      _linkAndTypeWidget(),
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
