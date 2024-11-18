import 'package:flutter/material.dart';
import 'package:future_hub_test/constants/text_style.dart';
import 'package:future_hub_test/constants/widgets/title_text_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/color.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key, required this.latitude, required this.longitude});

  final String latitude;
  final String longitude;
  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  late String latitude;
  late String longitude;
  LatLng _center = const LatLng(0.0, 0.0);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      latitude = widget.latitude; // 16.8661
      longitude = widget.longitude; // 96.1954
      debugPrint("My db is $latitude $longitude");
      _center = LatLng(double.parse(latitude), double.parse(longitude));
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: _center,
          infoWindow: const InfoWindow(title: 'Myanmar Yangon'),
        ),
      );
    });

  }

  void _onMapCreated(GoogleMapController controller) {
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: TitleTextStyle(
            titleText: "Google Map",
            titleStyle: robotoFontStyleWC,
          ),
        ),
        backgroundColor: CustomColor.primaryBlue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10.0,
        ),
        markers: _markers,
      ),
    );
  }
}
