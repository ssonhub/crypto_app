/* Inside our model folder, create a currency.dart file that will contain our CryptoCurrency model. 
This model will extend Equatable which is a package that we will use to be able to compare objects easily. 

This model contains name, full name of the currency and its price.
We'll use a props getter for Equatable to be able to compare objects
We'll also have a factory that will generate a CryptoCurrency from
a Map (JSON format) that gets from thr request

Just remember that the factory is very dependent on the format that crypto compare sends to us*/

import 'dart:html';

import 'package:equatable/equatable.dart';

class CryptoCurrency extends Equatable {
  final String name;
  final String fullName;
  final double price;

  const CryptoCurrency({
    required this.name,
    required this.fullName,
    required this.price,
  });

  @override
  List<Object?> get props => [name, fullName, price];

  factory CryptoCurrency.fromMap(Map<String, dynamic> map) {
    return CryptoCurrency(
      name: map['CoinInfo']?['Name'] ?? '',
      fullName: map['CoinInfo']?['FullName'] ?? '',
      price: (map['RAW']?['USD']?['PRICE'] ?? 0).toDouble(),
    );
  }
}
