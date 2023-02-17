import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:card/features/card/presentation/bloc/actions_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/actions_card_event.dart';
import '../widgets/finalCard.dart';

class FinalPage extends StatelessWidget {
  final List<CardEntity> cardData;

  const FinalPage({super.key, required this.cardData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F7F9),
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 15, color: Color(0xff000000)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Image.asset('assets/message.png')),
          IconButton(
              onPressed: () {
                BlocProvider.of<AddUpdateGetCardBloc>(context)
                  .add(AddCardEvent(
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
    return ListView(
      children: [
        Container(
            // padding: EdgeInsets.only(bottom: 28),
            margin: const EdgeInsets.only(top: 10, left: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Shipping Address'),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(17),
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
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
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Summary Order'),
                    Container(
                      padding: const EdgeInsets.all(17),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const[ Text('Delivery Fee'),  Text('\$4,00')],
                          ),
                          Container(
                            height: 2,
                            color: const Color(0xffE2E6E8),
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width - 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:const[ Text('Delivery Fee'), Text('\$4,00')],
                          ),
                          Container(
                            height: 2,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            color: const Color(0xffE2E6E8),
                            width: MediaQuery.of(context).size.width - 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [ Text('Delivery Fee'),  Text('\$4,00')],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(

                  height: MediaQuery.of(context).size.height/3,
                  child: finalCard(

                    card: cardData.where((card) => card.selected = true).toList(),
                  ),
                )
              ],
            )),
        Container(
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
                children: [
                  const Text('Total Payment'),
                  Text(
                      '\$ ${cardData.where((card) => card.selected = true).map((card) => card.price * card.countOfNeeded).toList().reduce((value, element) => value + element)}'),
                ],
              ),
              MaterialButton(
                minWidth: 200.0,
                height: 35,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                color: const Color(0xFFFFB039),
                child:  const Text('Continue',
                    style:  TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  BlocProvider.of<AddUpdateGetCardBloc>(context)
                    .add(UpdateCardEvent(card: cardData));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
