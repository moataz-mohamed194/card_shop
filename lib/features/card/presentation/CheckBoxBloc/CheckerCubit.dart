
import 'package:bloc/bloc.dart';
import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CounterBloc/CounterCubit.dart';

class CheckerCubit extends Cubit<bool> {
  CheckerCubit() : super(false);

  void changeCheck(CardEntity card,BuildContext context) {
    card.selected = !state;

    emit(!state);

    BlocProvider.of<CounterCubit>(context)
        .changeCheck0(
        card);
  }
}
