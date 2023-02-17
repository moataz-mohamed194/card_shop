import 'package:bloc/bloc.dart';
import 'package:card/features/card/domain/entities/CardEntity.dart';



class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
int totalCounter = 0;
double totalPrice = 0.0;
  void increment(CardEntity card) {
    if (card.count >= state + 1) {
      emit(card.countOfNeeded + 1);
      card.countOfNeeded = state;
      if (card.selected == true){
        totalCounter =totalCounter +1;
        print(totalPrice);
        print(card.countOfNeeded);
        print(card.price);
        totalPrice = totalPrice + (1 *card.price);
        print(totalPrice);
      }
    }
  }

  void decrement(CardEntity card) {
    if (card.countOfNeeded > 0) {
      emit(card.countOfNeeded - 1);
      card.countOfNeeded = state;
      if (card.selected == true){
        totalCounter =totalCounter -1;//card.countOfNeeded;

        totalPrice = totalPrice - 1 *card.price;
      }
    }
  }
  void changeCheck(CardEntity card ) {

    print(card.selected);

    if(card.selected == true){

        totalCounter =totalCounter +card.countOfNeeded;
        totalPrice = totalPrice + (card.countOfNeeded *card.price);

      }else {

      totalCounter = totalCounter - card.countOfNeeded;
      totalPrice = totalPrice - (card.countOfNeeded *card.price);

    }

    emit(0);


  }

}
