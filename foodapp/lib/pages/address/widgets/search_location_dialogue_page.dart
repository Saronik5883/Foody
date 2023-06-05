import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../utils/dimensions.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width20, right: Dimensions.width20),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Container(
            child: SingleChildScrollView(
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Search Location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                  ),
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                ),
                onSuggestionSelected: (Prediction suggestion) {
                  Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                  Get.back();
                },
                suggestionsCallback: (pattern) async {
                  return await Get.find<LocationController>().searchLocation(context, pattern);
                },
                itemBuilder: (context, Prediction suggestion) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        Expanded(
                            child: Text(
                              suggestion.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ),
      ),
    );
  }
}
