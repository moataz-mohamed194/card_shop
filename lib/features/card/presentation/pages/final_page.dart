import 'dart:async';

import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:card/features/card/presentation/bloc/actions_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/actions_card_event.dart';
import '../bloc/actions_card_state.dart';
import '../../../../injection_container.dart' as di;
import '../widgets/ListCard.dart';

class FinalPage extends StatelessWidget {
  final List<CardEntity> cardData;

  const FinalPage({super.key, required this.cardData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7F9),
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: 15, color: Color(0xff000000)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFFFFFF),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Image.asset('assets/message.png')),
          IconButton(
              onPressed: () {
                BlocProvider.of<AddUpdateGetCardBloc>(context)
                  ..add(AddCardEvent(
                      card: CardEntity(
                    name: 'watches',
                    count: 5,
                    image: "assets/Group 212.png",
                    price: 100,
                  )));
              },
              icon: Image.asset('assets/CompositeLayer.png')),
        ],
        elevation: 1,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              // padding: EdgeInsets.only(bottom: 28),
              margin: EdgeInsets.only(top: 10, left: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shipping Address'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(17),
                        margin: EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Domen Tikoro Street: 825 Baker Avenue, Dallas, Texas, Zip code 75202'),
                            Text(
                              'Change address',
                              style: TextStyle(color: Color(0xff01A688)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Summary Order'),
                      Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Delivery Fee'), Text('\$4,00')],
                            ),
                            Container(
                              height: 2,
                              color: Color(0xffE2E6E8),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: MediaQuery.of(context).size.width - 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Delivery Fee'), Text('\$4,00')],
                            ),
                            Container(
                              height: 2,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              color: Color(0xffE2E6E8),
                              width: MediaQuery.of(context).size.width - 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Delivery Fee'), Text('\$4,00')],
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height / 5
              : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffF3F7F9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Payment'),
                  Text('\$1,468.20'),
                ],
              ),
              MaterialButton(
                minWidth: 200.0,
                height: 35,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                color: Color(0xFFFFB039),
                child: new Text('Continue)',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  BlocProvider.of<AddUpdateGetCardBloc>(context)
                    ..add(UpdateCardEvent(card: this.cardData));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
