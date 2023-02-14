import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:equatable/equatable.dart';

abstract class AddUpdateGetCardState extends Equatable {
  const AddUpdateGetCardState();

  @override
  List<Object> get props => [];
}

class CardInitial extends AddUpdateGetCardState {}

class LoadingCardState extends AddUpdateGetCardState {}

class LoadedCardState extends AddUpdateGetCardState {
  final List<CardEntity> card;

  LoadedCardState({required this.card});

  @override
  List<Object> get props => [card];
}

class ErrorCardState extends AddUpdateGetCardState {
  final String message;

  ErrorCardState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateGetCardState extends AddUpdateGetCardState {
  final String message;

  MessageAddUpdateGetCardState({required this.message});

  @override
  List<Object> get props => [message];
}
