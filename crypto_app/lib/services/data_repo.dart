/* this file will be responsible to communicate with
the outside world and fetch the data we need in the app*/

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/currency.dart';
import '../model/data_error.dart';

class CryptoRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com/';
  final http.Client _httpClient;

// Let's set up a HTTP Client in the constructor to be able to make HTTP requests later
  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /* Let's now create a method called getCurrencies that will ask CryptoCompare
for a list of the top 25 crypto coins out there. This method will return a
Future<List<CryptoCurrency>>. Don't worry about the CryptoCurrency for now. */

  Future<List<CryptoCurrency>> getCurrencies() async {
    // To start fetching, let's define our request URL inside the method

    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=25&tsym=USD&page=0';

/* we'll use HTTP Get request to request the list of coins we need.
We need to call the get method of the HTTP Client, and provide the request URL we created above.
It has to be in URI format, so we can use URI.parse to convert our request string to URI.
Notice we'll wrap in a try/catch in case it fails.
If it fails, we'll throw a DataError with a message */

    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        // When some piece of data is delivered view HTTP requests, it is usually encoded in JSON format.
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        return coinList.map((e) => CryptoCurrency.fromMap(e)).toList();
      }
      return [];
    } catch (err) {
      throw DataError(message: err.toString());
    }
  }
}
