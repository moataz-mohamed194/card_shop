import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'features/card/presentation/CheckBoxBloc/CheckerCubit.dart';
import 'features/card/presentation/CounterBloc/CounterCubit.dart';
import 'package:path/path.dart';
import 'features/card/presentation/bloc/actions_card_bloc.dart';
import 'features/card/presentation/pages/cardPage.dart';
import '../../../../injection_container.dart' as di;

Future<void> main() async {
  // Get a location using getDatabasesPath
  WidgetsFlutterBinding.ensureInitialized();

  openDatabase(
    join(await getDatabasesPath(), 'demo3.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
       db.execute(
        'CREATE TABLE Product("id" INTEGER PRIMARY KEY, "name" TEXT,"image" TEXT,"count" INTEGER,"price" TEXT)',
      );
       return db.execute(
         'CREATE TABLE "Order"(id INTEGER PRIMARY KEY, "id_product" INTEGER, "count" INTEGER)',
       );
      //  CREATE TABLE ""."Order" (
      // "id_product"	INTEGER,
      // "count"	INTEGER
      // );
    },
    // await database;

    version: 1,
  );
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> di.sl<AddUpdateGetCardBloc>()),
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
        BlocProvider(
          create: (_) => CheckerCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CardPage(),
      ),
    );
  }
}
