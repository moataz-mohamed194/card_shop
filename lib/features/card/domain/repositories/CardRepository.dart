import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../entities/CardEntity.dart';

abstract class CardRepository {
  Future<Either<Failures, Unit>> addCardData(CardEntity card);
  Future<Either<Failures, Unit>> updateCard(List<CardEntity> card);
  Future<Either<Failures, List<CardEntity>>> getCardData();
}
