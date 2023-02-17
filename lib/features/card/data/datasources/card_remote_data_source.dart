import 'dart:convert';
import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import '../../../../core/error/Exception.dart';
import '../models/card_model.dart';

abstract class CardRemoteDataSource {
  Future<List<CardModel>> getAllCard();
  Future<Unit> updateCard(List<CardEntity> card);
  Future<Unit> addCard(CardEntity card);
  Future<Unit> deleteCard(CardEntity card);
}

class CardRemoteDataSourceImple extends CardRemoteDataSource {

  @override
  Future<Unit> addCard(CardEntity card) async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'demo3.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE Product(id INTEGER PRIMARY KEY, name TEXT,image TEXT,count INTEGER,price TEXT)',
          );
        },
        version: 1,
      );

      await db.insert(
        'Product',
        card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<List<CardModel>> getAllCard() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'demo3.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE Product(id INTEGER PRIMARY KEY, name TEXT,image TEXT,count INTEGER,price TEXT)',
          );
        },
        version: 1,
      );

      final List<Map<String, dynamic>> maps = await db.query(
        'Product', where: 'count >= ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [1],
      );
      return List.generate(maps.length, (i) {
        return CardModel(
          id: maps[i]['id'],
          name: maps[i]['name'],
          price: double.parse(maps[i]['price']),
          image: maps[i]['image'],
          count: maps[i]['count'],
        );
      });
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateCard(List<CardEntity> card) async {
    // TODO: implement updateCard
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'demo3.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE Order(id INTEGER PRIMARY KEY, id_product INTEGER,count INTEGER)',
          );
        },
        version: 1,
      );
      for (int i = 0; i < card.length; i++) {
        await db.insert(
          'Order',
          {'id_product': card[i].id, 'count': card[i].countOfNeeded},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await db.update(
          'Product',
          {
            'count': int.parse(card[i].count.toString()) -
                int.parse(card[i].countOfNeeded.toString())
          },
          where: 'id = ?',
          whereArgs: [card[i].id],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> deleteCard(CardEntity card) async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'demo3.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE Product(id INTEGER PRIMARY KEY, name TEXT,image TEXT,count INTEGER,price TEXT)',
          );
        },
        version: 1,
      );

      await db.delete(
        'Product',
        where: 'id = ?',
        whereArgs: [card.id],
      );
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }
}
