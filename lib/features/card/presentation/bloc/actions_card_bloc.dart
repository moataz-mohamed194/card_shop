import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import '../../domain/entities/CardEntity.dart';
import '../../domain/usecases/add_card.dart';
import '../../domain/usecases/delete_card.dart';
import '../../domain/usecases/get_all_card.dart';
import '../../domain/usecases/update_card_data.dart';
import 'actions_card_event.dart';
import 'actions_card_state.dart';

class AddUpdateGetCardBloc extends Bloc<CardEvent, AddUpdateGetCardState> {
  final AddCardData addCard;
  final DeleteCardData deleteCard;
  final UpdateCardData updateCard;
  final GetCardData getCard;

  AddUpdateGetCardBloc(
      {required this.addCard,required this.deleteCard, required this.updateCard, required this.getCard})
      : super(CardInitial()) {
    on<CardEvent>((event, emit) async {
      if (event is AddCardEvent) {
        emit(LoadingCardState());
        final failureOrDoneMessage = await addCard(event.card);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }else if (event is DeleteCardEvent) {
        emit(LoadingCardState());
        final failureOrDoneMessage = await deleteCard(event.card);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateCardEvent) {
        emit(LoadingCardState());
        final failureOrDoneMessage = await updateCard(event.card);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is GetCardEvent || event is RefreshCardEvent) {
        emit(LoadingCardState());
        final failureOrDoneMessage = await getCard();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddUpdateGetCardState
_mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorCardState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetCardState(
      message: message,
    ),
  );
}

AddUpdateGetCardState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<CardEntity>> either) {
  return either.fold(
    (failure) => ErrorCardState(message: _mapFailureToMessage(failure)),
    (card) => LoadedCardState(
      card: card,
    ),
  );
}

String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailures:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
