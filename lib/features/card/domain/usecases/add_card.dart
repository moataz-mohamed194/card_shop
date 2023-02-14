import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/CardEntity.dart';
import '../repositories/CardRepository.dart';

class AddCardData {
  final CardRepository repository;

  AddCardData(this.repository);

  Future<Either<Failures, Unit>> call(CardEntity card) async {
    return await repository.addCardData(card);
  }
}
