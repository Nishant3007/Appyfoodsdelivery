import 'dart:async';

import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../utils/utils.dart';

class GoogleMapScreen extends StatefulWidget {
  late final LatLng ?startLatLang;


  GoogleMapScreen(this.startLatLang);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng mDestinationLatLang = LatLng(30.333179, 78.010750);
  late LatLng mCurrentLatLang;
  late BitmapDescriptor customIcon;
  bool isOrderStarted = false;

  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> _markers = Set<Marker>();
  late final mMarkers = <MarkerId, Marker>{};
  MarkerId kMarkerId = MarkerId('MarkerId1');
  late LatLng currentLocation;
  late LatLng destinationLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Location mLocation = new Location();
  bool _mServiceEnabled = false;
  late LocationData mLocationData;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();

    mCurrentLatLang=widget.startLatLang!;

    BitmapDescriptor.fromAssetImage(ImageConfiguration(), Assets.ic_car_marker)
        .then((d) {
      customIcon = d;
    });

    this.setInitialLocation();
  }

  void setInitialLocation() {
/*    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);*/
    destinationLocation =
        LatLng(mDestinationLatLang.latitude, mDestinationLatLang.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.redColor,
        title: Text("Navigation"),
      ),
      body: Stack(
        children: [
          Animarker(
            mapId: mapController.future.then<int>((value) => value.mapId),
            markers: mMarkers.values.toSet(),
            useRotation: false,
            shouldAnimateCamera: false,
            child: GoogleMap(
              myLocationEnabled: false,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
                getLocationUpdates();
              },
              initialCameraPosition: CameraPosition(
                target: mCurrentLatLang,
                zoom: 13,
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOrderStarted = true;
                    });
                  },
                  child: Text("Start"),
                  style: ElevatedButton.styleFrom(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showMarker(LocationData locationData)async {
/*      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: CURRENT_LET_LNG,
          rotation: locationData.heading!,
          icon: customIcon,
          anchor: const Offset(0.5, 0.5)));*/

    getCenter() async {
      final GoogleMapController controller = await mapController.future;
      LatLngBounds bounds = await controller.getVisibleRegion();
      LatLng center = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );

      return center;
    }

      var marker = RippleMarker(
        markerId: kMarkerId,
        position: LatLng(mCurrentLatLang.latitude, mCurrentLatLang.longitude),
        rotation: locationData.heading!,
        anchor: const Offset(0.5, 0.5),
        ripple: true,
        zIndex: 4,
        icon: customIcon,
      );
      mMarkers[kMarkerId] = marker;

      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
      ));

  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyA2d1cY9e2gH7ApyRB_hw-nSxFykmk2sLM",
        PointLatLng(mCurrentLatLang.latitude, mCurrentLatLang.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    if (result.status == 'OK') {
      polylineCoordinates.clear();
      MyUtils().logger.i("POLY_RESULT: " + result.points.toString());
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 8,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    } else
      MyUtils()
          .logger
          .i("POLY_RESULT_ERROR: " + result.errorMessage.toString());
  }

  getLocationUpdates() async {
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _mServiceEnabled = await mLocation.serviceEnabled();
    if (!_mServiceEnabled) {
      _mServiceEnabled = await mLocation.requestService();
      if (!_mServiceEnabled) {
        return;
      }
    }

    _permissionGranted = await mLocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await mLocation.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    mLocation.enableBackgroundMode(enable: true);

    _locationData = await mLocation.getLocation();

    mCurrentLatLang = LatLng(_locationData.latitude!, _locationData.longitude!);

    //  setPolylines();
    //showMarker(_locationData);

    mLocationData=_locationData;

    //showMarker(_locationData);

    mLocation.changeSettings(
      interval: 2000);

    mLocation.onLocationChanged.listen((locationData) {
      MyUtils().logger.i(locationData.latitude.toString() +
          " " +
          locationData.longitude.toString());
      mCurrentLatLang = LatLng(locationData.latitude!, locationData.longitude!);
      setPolylines();
      showMarker(locationData);
      mLocationData=locationData;
      if (isOrderStarted == true)
        animateCurrentLocation(locationData);

    });
  }

  Future<void> animateCurrentLocation(LocationData locationData) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: locationData.heading!,
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 19,
        tilt: 60)));
  }
}
