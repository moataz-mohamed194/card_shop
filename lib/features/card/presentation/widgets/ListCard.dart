import 'dart:async';

import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CounterBloc/CounterCubit.dart';
import '../CheckBoxBloc/CheckerCubit.dart';

class ListCard extends StatelessWidget {
  final List<CardEntity> card;

  ListCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: card.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    BlocBuilder<CheckerCubit, bool?>(
                      builder: (context, state) {
                        print(card[index].selected);
                        return Checkbox(
                          activeColor: Color(0xff01A688),
                          value: card[index].selected,
                          onChanged: (bool? value) {
                            print(value);
                            context
                                .read<CheckerCubit>()
                                .changeCheck(card[index], value!);
                          },
                        );
                      },
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(card[index].image),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card[index].name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    BlocBuilder<CounterCubit, int>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Text(
                              '\$ ${num.parse(card[index].price.toString()) * num.parse(card[index].countOfNeeded.toString())}',
                              style: const TextStyle(
                                  fontSize: 15, color: Color(0xff02A88A)),
                            ),
// ToDo:remove it before u upload
                            Text(card[index].count.toString()),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 30,
                                  height: 30,
                                  child: InkWell(
                                      onTap: () => context
                                          .read<CounterCubit>()
                                          .increment(card[index]),
                                      child: const Icon(Icons.add)),
                                ),
                                Text('${card[index].countOfNeeded}'),
                                Container(
                                  width: 25,
                                  height: 25,
                                  margin: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                      onTap: () {
                                        context
                                            .read<CounterCubit>()
                                            .decrement(card[index]);
                                      },
                                      child: const Icon(Icons.remove)),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {

                    },
                    icon: Image.asset('assets/Icon Rubish.png')),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
    //   ],
    // );
  }
}
