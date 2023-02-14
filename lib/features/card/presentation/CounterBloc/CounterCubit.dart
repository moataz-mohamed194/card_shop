import 'package:bloc/bloc.dart';
import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(CardEntity card) {
    if (card.count >= state + 1) {
      emit(card.countOfNeeded! + 1);
      card.countOfNeeded = state;
    }
  }

  void decrement(CardEntity card) {
    if (card.countOfNeeded! > 0) {
      emit(card.countOfNeeded! - 1);
      card.countOfNeeded = state;
    }
  }
}
