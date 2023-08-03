import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'EczaneDetay.dart';
import 'model_eczane_json.dart';
import 'model_ilceler_json.dart';
import 'model_iller_jason.dart';

void main() {
  runApp(MyApp());
}

const color_red=Color(0xFFA91B1C);
const color_red2=Color(0xFF630A10);
const color_red3=Color(0xFF810000);
const color_red4=Color(0xFFA20A0A);

const color_beyaz_ton=Color(0xFFFDF1D6);

String? plaka;
List<DatumClass> eczaneListesi=[];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.white ,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final url = Uri.parse('https://api.kadircolak.com/Konum/JSON/API/ShowAllCity');

  int ? counter;
  List<Sehir> cityResult = [];
  List<Ilce> districtResult = [];
  String dropdownValue_il="";
  String  dropdownValue_ilce="";
  List<DatumClass> pharmacyResult= [];

  String? plaka_bul(String city){
    for(int i=0;i<cityResult.length;i++){
      if(cityResult[i].text==city){
        return cityResult[i].id.toString() ;
      }
    }
    return null;
  }
  @override
  void initState() {
    super.initState();
    callCity();
    callPharmacy("", "");
  }

  Future callPharmacy(String il,String ilce) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer Api_Token',
    };
     final params = {
      'city': '$il'.toLowerCase().replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ç", "c").replaceAll("ğ", "g"),
      'county': '$ilce'.toLowerCase().replaceAll("ç", "c").replaceAll("ü", "u").replaceAll("ğ", "g").replaceAll("ö", "o"),
    };
    final url = Uri.parse('https://www.nosyapi.com/apiv2/pharmacy')
        .replace(queryParameters: params);

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status == 200) {
      var result = pharmacyFromJson(res.body);
      for (int i = 0; i < result.data.length; i++) {
        var result_p = DatumClass.fromJson(result.data.elementAt(i));

        if (mounted) {
          setState(() {
            pharmacyResult.add(result_p);
            //For testing api
            //print("pharmacyResult[0]:${pharmacyResult[0]}");
          });
        }
      }
    }
    else if (status != 200) throw Exception('http.get error: statusCode= $status');

  }
  Future<List<DatumClass>>eczaneGetir(List<DatumClass> eczaneListe) async{

    return eczaneListe;
  }
  Future callCity() async {
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var result = sehirFromJson(response.body);
        if (mounted) {
          setState(() {
            cityResult = result;
            //For testing api
            //print("cityResult[5].text: ${cityResult[5].text}");
          });
          }
        }
      else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future callDistrict(String plaka) async {
    final url_ilce = Uri.parse('https://api.kadircolak.com/Konum/JSON/API/ShowDistrict?plate=${plaka}');

    try {
      http.Response response_ilce = await http.get(url_ilce);

      if (response_ilce.statusCode == 200) {
       // var result_ilce = ilceikiFromJson(response_ilce.body);
        var result_ilce = IlceFromJson(response_ilce.body);

        if (mounted) {
          setState(() {
            districtResult=result_ilce;
            //For testing api
            // print("city:${districtResult[5].city}");
            // print("district:${districtResult[5].district}");
          });
        }
      }
      else {
        print(response_ilce.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi= MediaQuery.of(context);
    final double ekranYuksekligi= ekranBilgisi.size.height;
    final double ekranGenisligi= ekranBilgisi.size.width;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 16,
        shadowColor: color_red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100), ),
        side: BorderSide(
          width:3,
          color: color_red4,
          style: BorderStyle.solid,

        ),),
        toolbarHeight: 150,
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(
              width: ekranGenisligi/5,
              height: ekranGenisligi/5,
            ),
            SizedBox(
                width: ekranGenisligi/5,
                height:ekranGenisligi/5,
                child: Image.asset("resimler/eczane-logo.jpeg")),
            SizedBox(
              width: ekranGenisligi/15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nöbetçi',style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: ekranGenisligi/11.8)),),
                Text('Eczane',style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: ekranGenisligi/11)),),
              ],
            ),

          ],
        ),
        backgroundColor:  color_red,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
            Column(
              children: [
                Theme(
                    data: theme,
                    child: Divider()),
                DecoratedBox(
                  decoration: BoxDecoration(
                      color:Colors.white, //background color of dropdown button
                      border: Border.all(color: color_red3, width:3), //border of dropdown button
                      borderRadius: BorderRadius.all(Radius.circular(10)), //border raiuds of dropdown button
                      boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                              ]
                  ),
                  child: Container(
                    width: ekranGenisligi/2,
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor: Colors.white , //color_beyaz_ton,
                        hint: Padding(
                          padding: EdgeInsets.only(left: ekranGenisligi/30),
                          child: Text("İl seçiniz",style: TextStyle(fontWeight: FontWeight.bold,),
                          ),
                        ),
                        value:dropdownValue_il == "" ? null : dropdownValue_il,
                        icon: Padding(
                          padding: EdgeInsets.only(right: ekranGenisligi/50),
                          child: const Icon(Icons.arrow_drop_down,color: color_red3,),
                        ),
                        elevation: 16,
                        style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black),),
                        onChanged: (String? value) {
                          dropdownValue_ilce="";
                          // This is called when the user selects an item.
                          setState(() {
                            eczaneListesi.clear();
                            dropdownValue_il = value!;
                            print(value);
                            plaka=plaka_bul(value)!;
                            print("plaka: ${plaka}");
                            print("İstanbul".toLowerCase());
                            callDistrict(plaka!);
                          });
                          },
                        items: cityResult.map<DropdownMenuItem<String>>((Sehir value) {
                          return DropdownMenuItem<String>(
                            value: value.text,
                            child: Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/30),
                              child: Text(value.text),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Theme(
                    data: theme,
                    child: Divider()),
                DecoratedBox(
                  decoration: BoxDecoration(
                      color:Colors.white, //background color of dropdown button
                      border: Border.all(color: color_red3, width:3), //border of dropdown button
                     // borderRadius: BorderRadius.only(topRight: Radius.elliptical(10, 10),bottomLeft: Radius.elliptical(10, 10)), //border raiuds of dropdown button
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]
                  ),
                  child: Container(
                    width: ekranGenisligi/2,
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        hint: Padding(
                          padding: EdgeInsets.only(left: ekranGenisligi/30),
                          child: Text("İlçe seçiniz",style: TextStyle(fontWeight: FontWeight.bold,),),
                        ),
                        value:dropdownValue_ilce == "" ? null : dropdownValue_ilce,
                        icon: Padding(
                          padding: EdgeInsets.only(right:ekranGenisligi/50,),
                          child: const Icon(Icons.arrow_drop_down,color: color_red3,),
                        ),
                        elevation: 16,
                        style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black),),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            eczaneListesi.clear();
                            dropdownValue_ilce = value!;
                            print(value);
                            callPharmacy(dropdownValue_il.toLowerCase().replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ç", "c").replaceAll("ğ", "g").replaceAll("ö", "o")
                                ,dropdownValue_ilce.toLowerCase().replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ç", "c").replaceAll("ğ", "g").replaceAll("ö", "o"),);
                          });
                          },
                        items: districtResult.map<DropdownMenuItem<String>>((Ilce value) {
                          return DropdownMenuItem<String>(
                            value: value.district,
                            child: Padding(
                              padding:  EdgeInsets.only(left:ekranGenisligi/30),
                              child: Text(value.district),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Theme(
                    data: theme,
                    child: Divider()),
                FutureBuilder<List<DatumClass>>(
                    future:eczaneGetir(pharmacyResult),
                    builder: (context,snaphot){
                      if(snaphot.hasData){
                        eczaneListesi=snaphot.data!;
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: eczaneListesi.length,
                            itemBuilder: (context,indeks){
                              var eczane= eczaneListesi[indeks];
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: color_red.withOpacity(.1),
                                        blurRadius: 1.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlipCard(
                                      fill: Fill.fillFront, // Fill the back side of the card to make in the same size as the front.
                                      direction: FlipDirection.VERTICAL, // default
                                      side: CardSide.FRONT,
                                      back: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 8.0,top: 6,),
                                                  child: GestureDetector(
                                                      onTap:  () async {
                                                        final Uri url_tel= Uri(
                                                          scheme: 'tel',
                                                          path: '${eczane.telefon}',
                                                        );
                                                        if (await canLaunchUrl(url_tel)){
                                                          await launchUrl(url_tel);
                                                        }
                                                        else{
                                                          print("Can not launch this");
                                                        }
                                                        },
                                                      child: Text(eczane.telefon,style:GoogleFonts.lora(textStyle:TextStyle(fontSize: ekranGenisligi/22,fontWeight:FontWeight.bold,color: color_red4),),)),),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 8.0,top:8,bottom: 6),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder:(context)=>
                                                          EczaneDetay(eczane:eczane)));
                                                              //MapUtils.openMap(eczane.address);
                                                    },
                                                    child: AutoSizeText(eczane.adresi,style: GoogleFonts.robotoSlab(textStyle:TextStyle(decoration: TextDecoration.underline,fontSize: ekranGenisligi/26,color:color_red2,),),
                                                      maxLines: 2, // Limit to a single line
                                                      minFontSize: 14, // Minimum font size
                                                      stepGranularity: 1, // Font size change granularity),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      front: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title:Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 8.0,left: 8.0,top: ekranYuksekligi/35),
                                                  child: Text(eczane.eczaneAdi,style:GoogleFonts.lora(textStyle:TextStyle(fontSize: 22,fontWeight:FontWeight.bold,color: color_red4),),),
                                                ),
                                              ],
                                            ),
                                            leading: Padding(
                                              padding: EdgeInsets.only(right: 8.0,left: 8.0,top: ekranYuksekligi/60),
                                              child: Icon(Icons.medical_services,
                                                color: color_red,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            );
                      }
                      else if(!snaphot.hasData){
                        return Center(
                          child: Text("Hata1: ${snaphot.error}"),
                        );
                      }
                      else{
                        return Center(
                          child: Text("Hata: ${snaphot.error}"),
                        );
                      }
                    }
                    ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
