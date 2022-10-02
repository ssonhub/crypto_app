/* this file is used for our app to know the current state */

// part of 'crypto_block.dart';

import 'package:crypto_app/model/currency.dart';
import 'package:crypto_app/model/data_error.dart';
import 'package:equatable/equatable.dart';

enum Status { initial, loading, loaded, error }

/* create a class CryptoState that extends Equatable that will have 3 main properties 
1. List coins
2. Status status
3. DataError onError*/

class CryptoState extends Equatable {
  final List<CryptoCurrency> coins;
  final Status status;
  final DataError onError;

  const CryptoState({
    required this.coins,
    required this.status,
    required this.onError,
  });

  /* Inside the class, let's create a start factory that will represent
  the initial state of our state */

  factory CryptoState.start() => const CryptoState(
        coins: [],
        status: Status.initial,
        onError: DataError(),
      );

  @override
  List<Object> get props => [coins, status, onError];

  /* we need a copyWith method to be able to update our state when we need it */
  CryptoState copyWith({
    List<CryptoCurrency>? coins,
    Status? status,
    DataError? failure,
  }) {
    return CryptoState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
      onError: failure ?? this.onError,
    );
  }
}
