import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';
import 'collecting_data_title.dart';

class CollectingDataTwo extends StatefulWidget {
  final Function prevPage;
  final Function submit;
  CollectingDataTwo(this.prevPage, this.submit);

  @override
  _CollectingDataTwoState createState() => _CollectingDataTwoState();
}

class _CollectingDataTwoState extends State<CollectingDataTwo> {
  LatLng currentPosition;
  bool loading;
  String currentAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (loading) {
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      currentPosition = LatLng(_locationData.latitude, _locationData.longitude);
      currentAddress = await getAddress(currentPosition);
      setState(() {
        loading = false;
      });
    }
  }

  Future<String> getAddress(LatLng position) async {
    final coordinates = new Coordinates(position.latitude, position.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    return first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 32,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  CollectingDataTitle(
                      'One step left, pick your location so we can deliver to you.'),
                  Expanded(
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Stack(
                            children: [
                              GoogleMap(
                                myLocationEnabled: true,
                                onCameraIdle: () async {
                                  currentAddress =
                                      await getAddress(currentPosition);
                                  setState(() {});
                                },
                                onCameraMove: (position) {
                                  setState(() {
                                    currentPosition = position.target;
                                  });
                                },
                                initialCameraPosition: CameraPosition(
                                    target: currentPosition, zoom: 14),
                              ),
                              Card(
                                elevation: 20,
                                margin: EdgeInsets.fromLTRB(16, 60, 16, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(currentAddress),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 35 / 2),
                                child: Center(
                                  child: Icon(
                                    Icons.place,
                                    size: 35,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowButton.left(
                      label: 'Back',
                      onPressed: () {
                        widget.prevPage();
                      }),
                  ArrowButton.right(
                    label: 'Submit',
                    onPressed: () {
                      widget.submit(currentPosition, currentAddress);
                    },
                  ),
                ],
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
