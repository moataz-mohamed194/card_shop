import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/CardEntity.dart';
import '../repositories/CardRepository.dart';

class GetCardData {
  final CardRepository repository;

  GetCardData(this.repository);

  Future<Either<Failures, List<CardEntity>>> call() async {
    return await repository.getCardData();
  }
}
