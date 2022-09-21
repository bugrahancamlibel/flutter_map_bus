import 'package:flutter_riverpod/flutter_riverpod.dart';

final townProvider = StateNotifierProvider<TownNotifier, Map?>((create){
  return TownNotifier({});
});

class TownNotifier extends StateNotifier<Map?> {
  TownNotifier(Map state) : super(state);

  setCurrentTown(Map town){
    state = town;
  }

  getTravelers(){
    return state;
  }
}