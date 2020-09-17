import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  List currencies = await getCurrencies();
  print(currencies.length);
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InCoin',
      theme: new ThemeData(
          primarySwatch: Colors.amber,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.blueGrey
              : null),
      home: new HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String url =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=50";
  http.Response response = await http.get(
    url,
    headers: {
      'X-CMC_PRO_API_KEY': 'Your API',
      "Accept": "application/json",
    },
  );

  // var x = json.decode(response.body)['data'];
  // print(x);
  return json.decode(response.body)['data'];

  //return json.decode(response.body);
}
