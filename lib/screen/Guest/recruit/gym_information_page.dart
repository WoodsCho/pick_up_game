import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const LatLng currentLocation = LatLng(25.1193, 55.3773);

class GymInformationPage extends StatefulWidget {
  const GymInformationPage({Key? key}) : super(key: key);

  @override
  State<GymInformationPage> createState() => _GymInformationPage();
}

class _GymInformationPage extends State<GymInformationPage> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(target: currentLocation, zoom: 14),
              onMapCreated: (controller) {
                mapController = controller;
              },
              markers: _markers.values.toSet(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
              // 위치 텍스트 입력을 위한 뷰를 추가하세요
              ),
        ),
      ],
    );
  }
}
