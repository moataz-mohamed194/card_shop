
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/card/data/datasources/card_remote_data_source.dart';
import 'features/card/data/repositories/card_repositories.dart';
import 'features/card/domain/repositories/CardRepository.dart';
import 'features/card/domain/usecases/add_card.dart';
import 'features/card/domain/usecases/delete_card.dart';
import 'features/card/domain/usecases/get_all_card.dart';
import 'features/card/domain/usecases/update_card_data.dart';
import 'features/card/presentation/bloc/actions_card_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async{

  //Bloc
  sl.registerFactory(() => AddUpdateGetCardBloc(addCard: sl(),
      updateCard: sl(),
      getCard: sl(), deleteCard: sl()));

  //UseCase
  sl.registerLazySingleton(() => AddCardData(sl()));
  sl.registerLazySingleton(() => GetCardData(sl()));
  sl.registerLazySingleton(() => UpdateCardData(sl()));
  sl.registerLazySingleton(() => DeleteCardData(sl()));


  //Repository
  sl.registerLazySingleton<CardRepository>(() => CardRepositoriesImpl(
      remoteDataSource: sl()));

  //Datasources
  sl.registerLazySingleton<CardRemoteDataSource>(() =>
      CardRemoteDataSourceImple());


  //External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
}