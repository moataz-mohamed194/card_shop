import 'package:bloc/bloc.dart';
import 'package:card/features/card/domain/entities/CardEntity.dart';

class CheckerCubit extends Cubit<bool> {
  int countOfList = 0;
  CheckerCubit() : super(false);

  void changeCheck(CardEntity card, bool value) {
    card.selected = !state;

    emit(!state);
    if (card.selected == true) {
      countOfList++;
    } else {
      countOfList--;
    }
  }
}

class TotalCubit extends Cubit<String> {
  final List<CardEntity> countOfList;
  TotalCubit(this.countOfList) : super('');

  String getTotal(List<CardEntity> countOfList) {
    print(countOfList.where((element) => element.selected =true).map((e) => e.countOfNeeded * e.price).toList().reduce((value, element) => value + element).toString());
    emit(countOfList.where((element) => element.selected =true).map((e) => e.countOfNeeded * e.price).toList().reduce((value, element) => value + element).toString().toString());
    return (countOfList.where((element) => element.selected =true).map((e) => e.countOfNeeded * e.price).toList().reduce((value, element) => value + element).toString());

  }
}
