import 'dart:async';

import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:card/features/card/presentation/bloc/actions_card_bloc.dart';
import 'package:card/features/card/presentation/pages/final_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../CheckBoxBloc/CheckerCubit.dart';
import '../bloc/actions_card_event.dart';
import '../bloc/actions_card_state.dart';
import '../../../../injection_container.dart' as di;
import '../widgets/ListCard.dart';

class CardPage extends StatelessWidget {
  late List<CardEntity> cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7F9),
      appBar: AppBar(
        title: Text(
          'Your Cart',
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
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: BlocProvider<AddUpdateGetCardBloc>(
                  create: (context) =>
                      di.sl<AddUpdateGetCardBloc>()..add(GetCardEvent()),
                  child:
                      BlocBuilder<AddUpdateGetCardBloc, AddUpdateGetCardState>(
                    builder: (context, state) {
                      if (state is LoadingCardState) {
                        return LoadingWidget();
                      } else if (state is LoadedCardState) {
                        this.cards = state.card;

                        return RefreshIndicator(
                            onRefresh: () => _onRefresh(context),
                            child: ListCard(
                              card: state.card,
                            ));
                      } else if (state is ErrorCardState) {
                        return MessageDisplayWidget(message: state.message);
                      }
                      return LoadingWidget();
                    },
                  ))),
        ),

        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height / 5
              : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffF3F7F9),
            // color: Colors.grey
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
                // child:  Text('Buy (${cards.where((CardEntity oneCard) => oneCard.selected == true).length} item)',
// child: BlocBuilder<CheckerCubit, int>(
//   builder: (context, state) {
//     return Text('Buy (${context.read<CheckerCubit>().countOfList} item)');
//   },
// ),
                child: Text('Buy (0 item)',
                    // child: Text('Buy (${context.read<CheckerCubit>().countOfList} item)',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  // for (int i = 0; i < cards.length; i++) {
                  //   if (cards[i].selected == true) {
                  //     print(cards[i].id);
                  //   }
                  // }
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FinalPage(cardData: this.cards)));
                },
              ),
            ],
          ),
        ),
        //   ),
        // )
      ],
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetCardBloc>(context)..add(GetCardEvent());
    } catch (e) {
      print(e);
    }
  }
}
