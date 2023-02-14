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
