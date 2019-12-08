import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int selectedIndex = 21;
  String selectedCurrency = currenciesList[21];
  CoinData coinData = CoinData();
  Map<String, double> rates;

  DropdownButton<String> androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map(
            (String currency) => DropdownMenuItem(
              child: Text(currency),
              value: currency,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getAllData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(initialItem: selectedIndex),
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          getAllData();
        });
      },
      children: currenciesList
          .map(
            (String currency) => Text(
              currency,
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  getAllData() async {
    var dataMap = await coinData.getAllCoinData(selectedCurrency);
    setState(() {
      rates = dataMap;
    });
  }

  String extractRateFromMap(String crypto) {
    if (null == rates) {
      return '?';
    }

    try {
      return rates[crypto].toStringAsFixed(4);
    } catch (e) {
      print(e);
      return '?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoList
                  .map(
                    (crypto) => Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 $crypto = ${extractRateFromMap(crypto)} $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
