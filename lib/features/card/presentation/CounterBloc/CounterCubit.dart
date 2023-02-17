import 'package:bloc/bloc.dart';
import 'package:card/features/card/domain/entities/CardEntity.dart';



class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(CardEntity card) {
    if (card.countOfNeeded < card.count) {
      emit(card.countOfNeeded + 1);
      card.countOfNeeded = state;
      // cart.changeCountNeededPlus(card.id!);

    }
    // print(card.toMap());
    // print(card.countOfNeeded);
  }

  void decrement(CardEntity card) {
    if (card.countOfNeeded > 0) {
      emit(card.countOfNeeded - 1);
      card.countOfNeeded = state;
      // cart.changeCountNeededminas(card.id!);

    }

  }
}
