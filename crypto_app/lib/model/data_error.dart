// we'll create a DataError model to handle errors throughout our app
// this model also extends equatable and we'll have a message String inside it

import 'package:equatable/equatable.dart';

class DataError extends Equatable {
  final String message;

  const DataError({this.message = ''});

  @override
  List<Object?> get props => [message];
}
