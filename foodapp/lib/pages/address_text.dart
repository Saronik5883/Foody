
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';
import '../controllers/user_controller.dart';


class AddressText extends StatefulWidget {
  const AddressText({Key? key}) : super(key: key);

  @override
  State<AddressText> createState() => _AddressTextState();
}

class _AddressTextState extends State<AddressText> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  late LatLng _initialPosition = LatLng(
      45.52563, -122.677433
  );

/*  @override
  void initState(){
    super.initState();
    _isLogged=Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition=LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;

    return Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Address ", style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
              leading: TextButton(
                child: const Text(""),
                onPressed: (){},
              ),
              scrolledUnderElevation: scrolledUnderElevation,
              shadowColor: Theme.of(context).colorScheme.shadow,

            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                width: Dimensions.screenWidth,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(51.509364, -0.128928),
                    zoom: 12,
                    maxZoom: 18
                  ),
                  nonRotatedChildren: [
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                        ),
                      ],
                    ),
                  ],
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    CurrentLocationLayer(
                      followOnLocationUpdate: FollowOnLocationUpdate.always,
                      turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                      style: const LocationMarkerStyle(
                        marker: DefaultLocationMarker(
                          child: Icon(
                            Icons.navigation,
                            color: Colors.white,
                          ),
                        ),
                        markerSize: Size(40, 40),
                        markerDirection: MarkerDirection.heading,
                      ),
                    )
                  ],
                ),
              )
            )

          ],


        )
    );
  }
}
