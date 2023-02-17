import 'dart:async';

import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CounterBloc/CounterCubit.dart';
import '../CheckBoxBloc/CheckerCubit.dart';
import '../bloc/actions_card_bloc.dart';
import '../bloc/actions_card_event.dart';
import '../pages/final_page.dart';

class ListCard extends StatelessWidget {
  final List<CardEntity> card;

  ListCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CheckerCubit(),
    child: BlocBuilder<CounterCubit, dynamic>(
        builder: (context, state) {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
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
                            BlocProvider(
                              create: (context) => CheckerCubit(),
                              child: BlocBuilder<CheckerCubit, bool>(
                                builder: (context, isChecked) {
                                  return Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      context.read<CheckerCubit>().changeCheck(card[index], context);
                                    },
                                  );
                                },
                              ),
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
                            Column(
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
                                          onTap: () {
                                            BlocProvider.of<CounterCubit>(context).increment(card[index]);},
                                          child: const Icon(Icons.add)),
                                    ),
                                    Text('${card[index].countOfNeeded}'),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      margin: const EdgeInsets.only(left: 10),
                                      child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<CounterCubit>(context).decrement(card[index]);

                                          },
                                          child: const Icon(Icons.remove)),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AddUpdateGetCardBloc>(context)
                                  .add(DeleteCardEvent(
                                  card: card[index]));
                              BlocProvider.of<AddUpdateGetCardBloc>(context)
                                  .add(GetCardEvent());

                            },
                            icon: Image.asset('assets/Icon Rubish.png')),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1),
            ),
          ),
          SizedBox(
            height: 100,
            child: Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height / 5
                  : 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xffF3F7F9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [const Text('Total Payment'), Text(context.read<CounterCubit>().totalPrice.toString())],
                  ),
                  MaterialButton(
                    minWidth: 200.0,
                    height: 35,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0)),
                    color: const Color(0xFFFFB039),
                    // data.map((card) => card.countOfNeeded).toList().reduce((value, element) => value + element)
                    child: Text('Buy (${context.read<CounterCubit>().totalCounter} item)',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => FinalPage(cardData: this.card)));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }));
  }
  //   ],
  // );
}
