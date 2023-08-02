import 'package:url_launcher/url_launcher.dart';

class   MapUtils{
  MapUtils._();

  static Future<void> openMap(String address) async{
    String googleUrl="https://maps.google.com/?q=${address}";
    if (await canLaunch(googleUrl)){
      await launch(googleUrl);
    }
    else{
      throw 'Could not open the map';
    }
  }
  _launchCaller() async {
    const url = "tel:1234567";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
