import 'package:bitcoin_ticker/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NGN',
  'NOK',
  'NZD',
  'PHP',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future<Map<String, double>> getAllCoinData(String currency) async {
    String coinsString = cryptoList.join(',');

    String url = '$baseUrl/short?crypto=$coinsString&fiat=$currency';
    NetworkHelper networkHelper = NetworkHelper(url);

    var jsonData = await networkHelper.getData();
    Map<String, double> coinData = {};

    cryptoList.forEach((crypto) {
      coinData['$crypto'] = jsonData['$crypto$currency']['last'];
    });

    print(coinData);

    return coinData;
  }
}
