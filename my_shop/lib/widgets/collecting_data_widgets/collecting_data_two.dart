import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';

import 'collecting_data_title.dart';

class CollectingDataTwo extends StatelessWidget {
  final Function prevPage;
  CollectingDataTwo(this.prevPage);
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
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            37.43296265331129,
                            -122.08832357078792,
                          ),
                          zoom: 14),
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
                        prevPage();
                      }),
                  ArrowButton.right(
                    label: 'Submit',
                    onPressed: () {},
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
