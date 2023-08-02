import 'package:http/http.dart' as http;

import 'model_pharmacy.dart';

void main() async {
  final headers = {
    'authorization': 'apikey 3QTNO9VyJZRegMkQ12UTQh:7wdDKv4Vtpzj9M0N7atrjX',
    'content-type': 'application/json',
  };

  final params = {
    'ilce': 'Elmadağ',
    'il': 'Ankara',
  };
  List<Eczane> pharmacyResult= [];

  final url = Uri.parse('https://api.collectapi.com/health/dutyPharmacy')
      .replace(queryParameters: params);

  final res = await http.get(url, headers: headers);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  print(res.body);
  var result = eczaneFromJson(res.body);
  print(result.result.elementAt(1));
  print(result.result.length);
  var a= result.result.elementAt(1);
  var result2 = ResultClass.fromJson(a);
  print(result2.name);



  //pharmacyResult =result;
}