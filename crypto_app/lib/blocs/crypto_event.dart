// crypto event is the simplest one.

// part of 'crpyto_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  // this'll represent a base event in our application
  @override
  List<Object> get props => [];
}

/* Let's create a Start event that will trigger once we start our app.
Start is also a class but it will extend our CryptoEvent class. 
Make sure to declare it under the CryptoEvent class. */
class Start extends CryptoEvent {}

/* Let's now create our last event which will be called
RefreshCoins which will be triggered when the pull to refresh in the app */

class RefreshCoins extends CryptoEvent {}
