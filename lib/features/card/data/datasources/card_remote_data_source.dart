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
}

class CardRemoteDataSourceImple extends CardRemoteDataSource {
  ///getAllClinic
  // @override
  // Future<List<CardModel>> getAllClinic() async {
  //   final response = await client.get(
  //       Uri.parse(BASE_URL+"/users/get_clinic_data/"),
  //       headers: {"Content-Type": "application/json"}
  //   );
  //   if (response.statusCode == 200){
  //     try {
  //       final List decodeJson = json.decode(response.body) as List;
  //       final List<ClinicModel> clinicModels = decodeJson
  //           .map<ClinicModel>((jsonClinicModel) =>
  //           ClinicModel.fromJson(jsonClinicModel))
  //           .toList();
  //       return clinicModels;
  //     }catch(e){
  //       throw OfflineException();
  //
  //     }
  //   }else{
  //     throw OfflineException();
  //   }
  // }
  ///addClinic
  // @override
  // Future<Unit> addClinic(Clinic clinic) async {
  //
  //   final body = {
  //     'address': clinic.addrees.toString(),
  //     'note': clinic.note.toString(),
  //     'time_of_vacation': clinic.timeOfVacation.toString(),
  //     'from_time': clinic.fromTime.toString(),
  //     'to_time': clinic.toTime.toString(),
  //     'latitude': clinic.latitude.toString(),
  //     'longitude': clinic.longitude.toString(),
  //   };
  //   try{
  //     final response = await client.post(Uri.parse(BASE_URL + '/doctor/model_of_clinic/'),body: body);
  //
  //     if (response.statusCode == 201 || response.body == '{"Results": "Success request"}'){
  //       return Future.value(unit);
  //     }else{
  //       throw OfflineException();
  //     }}
  //   catch(e){
  //     throw OfflineException();
  //   }
  // }
  ///updateClinic
  // @override
  // Future<Unit> updateClinic(Clinic clinic) async {
  // // Future<Unit> updateClinic(int id) async {
  //
  //   final body ={
  //     'address': clinic.addrees.toString(),
  //     'note': clinic.note.toString(),
  //     'time_of_vacation': clinic.timeOfVacation.toString(),
  //     'from_time': clinic.fromTime.toString(),
  //     'to_time': clinic.toTime.toString(),
  //     'pk':clinic.id.toString(),
  //     'latitude': clinic.latitude.toString(),
  //     'longitude': clinic.longitude.toString(),
  //   };
  //   final response = await client.patch(
  //       Uri.parse(BASE_URL+'/doctor/edit_data_clinic/'), body: body
  //   );
  //   if (response.statusCode == 200){
  //     return Future.value(unit);
  //   }else{
  //     throw OfflineException();
  //   }
  // }

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
          // Pass the Dog's id as a whereArg to prevent SQL injection.
          whereArgs: [card[i].id],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }
}
