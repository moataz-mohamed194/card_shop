import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/CardRepository.dart';

class UpdateCardData {
  final CardRepository repository;

  UpdateCardData(this.repository);

  Future<Either<Failures, Unit>> call(List<CardEntity> card) async {
    return await repository.updateCard(card);
  }
}
