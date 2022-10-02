// this file is responsible for managing everything

/* To create a Bloc class, we need to extend from Bloc providing a mapping
from Event to State */

import 'package:crypto_app/blocs/crypto_event.dart';
import 'package:crypto_app/blocs/crypto_state.dart';
import 'package:crypto_app/model/data_error.dart';
import 'package:crypto_app/services/data_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  /* Create a CryptoRepository variable inside it 
 which we will use to fetch the currencies */

  final CryptoRepository _cryptoRepository;

  /* create our constructor now. It'll be created with the CryptoRepository
  that we will provide and the state will be created */

  CryptoBloc({required CryptoRepository cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.start()) {
    /* we need a way to map our events and dispatch the correct states
          to it. To do that, we will register our events inside
          the constructor like so: */
    on<Start>((event, emit) => _start(emit));
    on<RefreshCoins>((event, emit) => _getCoins(emit));
  }
  /* The on function Register event handler for an event of type E, and
  it provides a callback with the event(state) and an emit function
  which is used for us to emit the state. In simpler words, this just lets
  our Bloc knows that it can expect 2 events to happen and when it happens,
  it will trigger those functions (_start and _getCoins which we'll create now) */

  /* Let's create our _getCoins method which will be responsible to get our
  currencies from the repository and update the state. It takes the emit as
  a parameter which is of type Emitter<CryptoState> and we will use that
  to emit the state change. Inside the method, we will get the coins,
  update the state, and return it. If it fails, we just update the state 
  accordingly like so :*/

  Future<CryptoState> _getCoins(Emitter<CryptoState> emit) async {
    try {
      // Get a list of our coins
      final coins = await _cryptoRepository.getCurrencies();
      /* If successful, the state is updated with the coins we have, with 
      an updated status*/
      // It is updated by calling emit(new state)

      emit(state.copyWith(coins: coins, status: Status.loaded));
      return state;
    } on DataError catch (err) {
      // fails we update the state accordingly
      emit(state.copyWith(
        failure: err,
        status: Status.error,
      ));
      return state;
    }
  }

  /* Now let's create our start function which is way simpler, as it will
    have an inital state of loading and will call the _getCoins to be
    able to display the list of cryptocurrencies when we open the app */

  Future<CryptoState> _start(Emitter<CryptoState> emit) async {
    state.copyWith(status: Status.loading);
    return _getCoins(emit);
  }
}
