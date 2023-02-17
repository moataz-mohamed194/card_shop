import 'package:flutter/cupertino.dart';

import 'dart:async';

import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CounterBloc/CounterCubit.dart';
import '../CheckBoxBloc/CheckerCubit.dart';

class finalCard extends StatelessWidget {
  final List<CardEntity> card;

  finalCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: card.length,
      itemBuilder: (context, index) {
        if (card[index].countOfNeeded>0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(card[index].image),
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card[index].name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$ ${num.parse(card[index].price.toString())}   count    ${card[index].countOfNeeded}',
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xff02A88A)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        else{
          return Container();
        }
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
    //   ],
    // );
  }
}
