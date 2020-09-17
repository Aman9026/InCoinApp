import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<dynamic> currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> currencies;
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("InCoin"),
        // elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemCount: widget.currencies.length,
          itemBuilder: (BuildContext context, int index) {
            Map currency = widget.currencies[index];
            MaterialColor color = _colors[index % _colors.length];

            return _getListItemUI(currency, color);
          },
        )),
      ]),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle:
          _getSubtitle(currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitle(String priceUSD, String percentagechange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD", style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentagechange";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentagechange) > 0) {
      percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText,
        style: new TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText,
        style: new TextStyle(color: Colors.red),
      );
    }
    return RichText(
      text:
          new TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
