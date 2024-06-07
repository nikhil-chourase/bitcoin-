import 'dart:convert';

import 'package:http/http.dart' as http;

const apikey = '8BEC75D5-B7D6-4B21-850E-0F6039EEDE83';

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
  'NOK',
  'NZD',
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

class CoinData {

  Future getCoinData(String currency) async{


    Map<String, String> cryptoPrices = {};


    for(String crypto in cryptoList){
      http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=8BEC75D5-B7D6-4B21-850E-0F6039EEDE83'));
      
       if(response.statusCode == 200){
        String data = response.body;
        print(data);
      }else{
        print(response.statusCode);
        throw 'problem with get request';  
      }

      var content = jsonDecode(response.body);

      double price = content['rate'];

      cryptoPrices[crypto] = price.toStringAsFixed(0);
      


    }

    return cryptoPrices;



   
  }


}


