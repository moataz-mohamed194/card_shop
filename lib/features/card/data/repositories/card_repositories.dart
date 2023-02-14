import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/CardRepository.dart';
import '../datasources/card_remote_data_source.dart';
import '../models/card_model.dart';

class CardRepositoriesImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;

  CardRepositoriesImpl(
      {required this.remoteDataSource});

  @override
  Future<Either<Failures, Unit>> addCardData(CardEntity card) async {
    final CardModel cardModel = CardModel(
        id: card.id,
        name: card.name,
        price: card.price,
        image: card.image,
        count: card.count);
      try {
        await remoteDataSource.addCard(cardModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }

  }

  @override
  Future<Either<Failures, List<CardEntity>>> getCardData() async {
      try {
        final currentCard = await remoteDataSource.getAllCard();
        return Right(currentCard);
      } on OfflineException {
        return Left(OfflineFailures());
      }

  }

  @override
  Future<Either<Failures, Unit>> updateCard(List<CardEntity> card) async {
      try {
        await remoteDataSource.updateCard(card);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }

  }
}
