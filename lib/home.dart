import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position ? _currentPosition;
  String ?  _currentAddress;
 @override
  void initState()  {
   permissionn();
    super.initState();
  }
void permissionn()async{
  LocationPermission permission = await Geolocator.requestPermission();
  print(permission);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentAddress != null) Text(
                _currentAddress!
            ),
            ActionChip(
              onPressed: () {
                _getCurrentLocation();
              }, label:  Text("Get location"),
            ),
          ],
        ),
      ),
    );
  }
  late Position position;
  _getCurrentLocation() async{
   position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
 setState(() {
   _currentPosition = position;
   print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${_currentPosition!.longitude}");
   print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${_currentPosition}");
 });
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "name = ${place.name}, street =${place.street.toString()}, subThoroughfare=${place.subThoroughfare}, subLocality=${place.subLocality}, administrativeArea=${place.administrativeArea}, isoCountryCode=${place.isoCountryCode},locality=${place.locality}, postalCode=${place.postalCode}, subAdministrativeArea=${place.subAdministrativeArea}, thoroughfare${place.thoroughfare}, country=${place.country},";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }

  }


}