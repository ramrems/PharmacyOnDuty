import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'EczaneDetayEski.dart';
import 'model_ilceler_json.dart';
import 'model_iller_jason.dart';
import 'model_pharmacy.dart';

void main() {
  runApp(MyApp());
  //callPharmacy("","");
}
/*
const color_card= Color(0xFFFFF8EA);
const color_body=Color(0xFFDCD7C9);
const color_appBar=Color(0xFFA27B5C);
const color_yazi=Color(0xFFA27B5C);
const color_buton2=Color(0xFFC8B6A6);
const color_buton1=Color(0xFFFFFFF8EA);
*/


const color_card= Color(0xFFFFFFF8EA);
const color_body=Color(0xFFDCD7C9);
const color_appBar=Color(0xFF815B5B);
const color_yazi=Color(0xFF9E7676);
//const color_buton2=Color(0xFFC8B6A6);
const color_buttons=Color(0xFFFFFFF8EA);
const color_icons=Color(0xFF815B5B);
const color_kahve=Color(0xFFC8B6A6);

const color_red=Color(0xFFA91B1C);
const color_red1=Color(0xFF850000);//çok koyu
const color_red1_2=Color(0xFFDC0000);
const color_red2=Color(0xFFB31312);
const color_red3=Color(0xFF630A10);//çok koyu
const color_red4=Color(0xFF810000);//çok koyu ,icon
const color_red5=Color(0xFF91091E);
const color_red6=Color(0xFFA20A0A);
const color_red7=Color(0xFF900D0D);



const color_beyaz1=Color(0xFFFFF6C3); //çok sarı
const color_beyaz2=Color(0xFFF5EEDC);
const color_beyaz3=Color(0xFFEEE2DE);//pembe tonlu
const color_beyaz4=Color(0xFFFCF0C8); //sarımsı yine
const color_beyaz5=Color(0xFFEEEBDD); //beğendim
const color_beyaz6=Color(0xFFFDF1D6);
const color_beyaz7=Color(0xFFF6EEC9);//sarımsı
const color_beyaz8=Color(0xFFFFDBC5); //aşırı pembe olmaz



const titleStyle = TextStyle(fontSize: 20);
const subTitleStyle = TextStyle(fontSize: 18);
String? plaka;
List<ResultClass> eczaneListesi=[];

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
  List<ResultClass> pharmacyResult= [];

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
      'authorization': 'apikey apikey 5a4R1xi4hGU2bHSsm9MNeq:5Tis9unmEPgu4Ndai3kYJs',
      'content-type': 'application/json',
    };
    /*Map<String, dynamic> requestPayload = {
      'ilce': '$ilce',
      'il': '$il',
    };*/

    final params = {
      'ilce': '$ilce',
      'il': '$il',
    };
    final url = Uri.parse('https://api.collectapi.com/health/dutyPharmacy')
        .replace(queryParameters: params);

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status == 200) {
      var result = eczaneFromJson(res.body);
      for (int i = 0; i < result.result.length; i++) {
        var result_p = ResultClass.fromJson(result.result.elementAt(i));

        if (mounted) {
          setState(() {
            pharmacyResult.add(result_p);
            print(pharmacyResult[0]);
            //print(cityResult[5].district);

          });
        }
      }
    }
    else if (status != 200) throw Exception('http.get error: statusCode= $status');

    print("body: ${res.body}");
    var result = eczaneFromJson(res.body);
    print("result:${result.result.elementAt(0)}");
    var a= result.result.elementAt(1);
    var result2 = ResultClass.fromJson(a);
    print(result2.name);
    print("Type: ${pharmacyResult.runtimeType}");
    //pharmacyResult =result;
  }
  Future<List<ResultClass>>eczaneGetir(List<ResultClass> eczaneListe) async{
    // var eczaneListe = <ResultClass>[];
    //
    // eczaneListe.add(pharmacyResult as ResultClass);
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
            print(cityResult[5].text);
            //print(cityResult[5].district);

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
            print("city:${districtResult[5].city}");
            print("district:${districtResult[5].district}");
          });
          // print(ditrictResult.first.district);
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
        appBar: AppBar(
          leading: Icon(Icons.local_hospital_sharp),
          title: Text('Nöbetçi Eczane',style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
          backgroundColor:  color_red,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                children: [
                  //Image.asset("resimler/nobetci_eczane.png"),
                  SizedBox(
                      width: ekranGenisligi/2,
                      height: ekranGenisligi/3,
                      child: Image.asset("resimler/nobetci_eczane.png")
                    //Image.asset("resimler/eczane_konum_icon.png"),
                  ),
                  Theme(
                      data: theme,
                      child: Divider()),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color:Colors.white, //background color of dropdown button
                        border: Border.all(color: color_red4, width:3), //border of dropdown button
                        borderRadius: BorderRadius.only(topRight: Radius.elliptical(10, 10),bottomLeft: Radius.elliptical(10, 10)), //border raiuds of dropdown button
                        boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]
                    ),
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white , //color_beyaz6,
                          hint: Text("İl seçiniz",style: TextStyle(fontWeight: FontWeight.bold),),
                          value:dropdownValue_il == "" ? null : dropdownValue_il,
                          icon: const Icon(Icons.arrow_drop_down,color: color_red4,),
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
                              //callCity();
                              callDistrict(plaka!);
                              //_MyHomePageState();
                            });
                          },
                          items: cityResult.map<DropdownMenuItem<String>>((Sehir value) {
                            return DropdownMenuItem<String>(
                              value: value.text,
                              child: Text(value.text),
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
                        border: Border.all(color: color_red4, width:3), //border of dropdown button
                        borderRadius: BorderRadius.only(topRight: Radius.elliptical(10, 10),bottomLeft: Radius.elliptical(10, 10)), //border raiuds of dropdown button
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
                          dropdownColor: Colors.white,
                          hint: Text("İlçe seçiniz",style: TextStyle(fontWeight: FontWeight.bold,),),
                          value:dropdownValue_ilce == "" ? null : dropdownValue_ilce,
                          icon: const Icon(Icons.arrow_drop_down,color: color_red4,),
                          elevation: 16,
                          style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black),),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              eczaneListesi.clear();
                              dropdownValue_ilce = value!;
                              print(value);
                              callPharmacy(dropdownValue_il,dropdownValue_ilce);
                            });
                          },
                          items: districtResult.map<DropdownMenuItem<String>>((Ilce value) {
                            return DropdownMenuItem<String>(
                              value: value.district,
                              child: Text(value.district),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                      data: theme,
                      child: Divider()),
                  FutureBuilder<List<ResultClass>>(
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
                                    decoration: new BoxDecoration(
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
                                      child: Container(
                                        //constraints: const BoxConstraints(minHeight: 0, maxHeight: 150.0),

                                        child: SingleChildScrollView(
                                          child: FlipCard(
                                            //flipOnTouch: true,
                                            fill: Fill.fillFront, // Fill the back side of the card to make in the same size as the front.
                                            direction: FlipDirection.VERTICAL, // default
                                            side: CardSide.FRONT,
                                            //borderOnForeground: true,
                                            //color:color_card,
                                            back: Container(
                                                //constraints: const BoxConstraints(minHeight: 0, maxHeight: 500.0),
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
                                                                path: '${eczane.phone}',
                                                              );
                                                              if (await canLaunchUrl(url_tel)){
                                                                await launchUrl(url_tel);
                                                              }
                                                              else{
                                                                print("Can not launch this");
                                                              }
                                                            },
                                                            child: Text(eczane.phone,style:GoogleFonts.lora(textStyle:TextStyle(fontSize: ekranGenisligi/22,fontWeight:FontWeight.bold,color: color_red6),),)),),
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 8.0,top:8,bottom: 6),
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder:(context)=>
                                                                EczaneDetay2(eczane:eczane)));
                                                            //MapUtils.openMap(eczane.address);
                                                          },
                                                          child: AutoSizeText(eczane.address,style: GoogleFonts.robotoSlab(textStyle:TextStyle(decoration: TextDecoration.underline,fontSize: ekranGenisligi/26,color:color_red3,),),
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
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(eczane.name,style:GoogleFonts.lora(textStyle:TextStyle(fontSize: 22,fontWeight:FontWeight.bold,color: color_red6),),),
                                                      ),
                                                      /*Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(eczane.dist,style: GoogleFonts.robotoSlab(textStyle:TextStyle(fontSize: 18,color: color_red3,),),),
                                                      ),*/
                                                    ],
                                                  ),
                                                  leading: Icon(Icons.medical_services,
                                                    color: color_red,),
                                                ),
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