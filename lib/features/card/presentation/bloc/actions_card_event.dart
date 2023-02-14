import 'package:equatable/equatable.dart';

import '../../domain/entities/CardEntity.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class AddCardEvent extends CardEvent {
  final CardEntity card;

  AddCardEvent({required this.card});

  @override
  List<Object> get props => [card];
}

class UpdateCardEvent extends CardEvent {
  final List<CardEntity> card;

  UpdateCardEvent({required this.card});

  @override
  List<Object> get props => [card];
}

class GetCardEvent extends CardEvent {}

class RefreshCardEvent extends CardEvent {}
