
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/CardEntity.dart';
import '../repositories/CardRepository.dart';

class DeleteCardData {
  final CardRepository repository;

  DeleteCardData(this.repository);

  Future<Either<Failures, Unit>> call(CardEntity card) async {
    return await repository.deleteCardData(card);
  }
}
