import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:nobetci_eczane/main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'googleMap.dart';
import 'model_pharmacy.dart';

//const MapUtils currentLocation= MapUtils(e);

const color_appBar=Color(0xFF815B5B);
const color_red6=Color(0xFFA20A0A);

const LatLng currentLocation=LatLng(41.015137, 28.979530);
class EczaneDetay2 extends StatefulWidget {

  //const EczaneDetay({super.key});
  ResultClass eczane;

  EczaneDetay2({required this.eczane});

  @override
  State<EczaneDetay2> createState() => _EczaneDetay2State();
}

class _EczaneDetay2State extends State<EczaneDetay2> {
  /* Position? _currentPosition;
  String? _currentAddress;*/
  //final url_map = Uri.parse('https://maps.google.com/?q=${widget.adress}');

/*Future<void> geoCode() async {
  String query = "1600 Amphiteatre Parkway, Mountain View";
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  print("${first.featureName} : ${first.coordinates}");
  //LatLng currentLocation=LatLng(${first.coordinates});
}*/


    CameraPosition _initialCameraPosition= CameraPosition(

      target: currentLocation,
      zoom: 15,);
    

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi= MediaQuery.of(context);
    final double ekranYuksekligi= ekranBilgisi.size.height;
    final double ekranGenisligi= ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:color_red,
        title: Text("Eczane Bilgileri"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.phone_rounded,color: Colors.green[700],),
                  GestureDetector(
                      onTap:  () async {
                        final Uri url_tel= Uri(
                          scheme: 'tel',
                          path: '${widget.eczane.phone}',
                        );
                        if (await canLaunchUrl(url_tel)){
                          await launchUrl(url_tel);
                        }
                        else{
                          print("Can not launch this");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.eczane.phone,style:GoogleFonts.lora(textStyle:TextStyle(fontSize: ekranGenisligi/20,fontWeight:FontWeight.bold,color: color_red6),),),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.location_pin,color: color_red6,),
                  Flexible(
                    child: SizedBox(
                      child: Container(
                        child:
                        GestureDetector(
                            onTap: (){
                              MapUtils.openMap(widget.eczane.address);
                            },
                            child: Text("Adres: ${widget.eczane.address}",style:GoogleFonts.lora(textStyle:TextStyle(fontSize: ekranGenisligi/26,fontWeight:FontWeight.bold,color: color_red6),),)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SizedBox(
                // width: 350,
                // height: 500,
                child: GestureDetector(
                  onTap: (){
                    MapUtils.openMap(widget.eczane.address);
                  },
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    //onMapCreated:(controller) => _googleMapController=controller,
                    //child: Text("Eczane Detay",style: TextStyle(fontSize: 40,color: Colors.blue),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed:()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: Icon(Icons.center_focus_strong),
      ),*/
    );
  }
}
