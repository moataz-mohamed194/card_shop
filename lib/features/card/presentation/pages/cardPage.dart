import 'package:card/features/card/domain/entities/CardEntity.dart';
import 'package:card/features/card/presentation/bloc/actions_card_bloc.dart';
import 'package:card/features/card/presentation/pages/final_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../data/models/card_model.dart';
import '../CheckBoxBloc/CheckerCubit.dart';
import '../bloc/actions_card_event.dart';
import '../bloc/actions_card_state.dart';
import '../../../../injection_container.dart' as di;
import '../widgets/ListCard.dart';

class CardPage extends StatelessWidget {
  late List<CardEntity> cards;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xffF3F7F9),
            appBar: AppBar(
              title: const Text(
                'Your Cart',
                style: TextStyle(fontSize: 15, color: Color(0xff000000)),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xffFFFFFF),
              actions: <Widget>[
                IconButton(
                    onPressed: () {}, icon: Image.asset('assets/message.png')),
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
            body: BlocProvider<AddUpdateGetCardBloc>(
                create: (context) =>
                    di.sl<AddUpdateGetCardBloc>()..add(GetCardEvent()),
                child: BlocBuilder<AddUpdateGetCardBloc, AddUpdateGetCardState>(
                  builder: (context, state) {
                    if (state is LoadingCardState) {
                      return LoadingWidget();
                    } else if (state is LoadedCardState) {
                      cards = state.card;
                      return Column(
                        children: [
                          state.card.isNotEmpty
                              ? Expanded(
                                  flex: 4,
                                  child: _buildBody(context, state.card),
                                )
                              : Container(),
                          state.card.isNotEmpty
                              ? Expanded(
                                  child: _bottomBody(context, state.card))
                              : Container(),
                        ],
                      );
                    } else if (state is ErrorCardState) {
                      return MessageDisplayWidget(message: state.message);
                    }
                    return LoadingWidget();
                  },
                ))));
  }

  Widget _buildBody(
    BuildContext context,
    List<CardEntity> data,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RefreshIndicator(
          onRefresh: () => _onRefresh(context), child: ListCard(card: data)),
    );
  }

  Widget _bottomBody(
    BuildContext context,
    List<CardEntity> data,
  ) {
    return SizedBox(
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
              children: const [Text('Total Payment'), Text('0')],
            ),
            MaterialButton(
              minWidth: 200.0,
              height: 35,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              color: const Color(0xFFFFB039),
              // data.map((card) => card.countOfNeeded).toList().reduce((value, element) => value + element)
              child: Text(
                  'Buy (${data.where((card) => card.selected = true).map((card) => card.countOfNeeded).toList().reduce((value, element) => value + element)} item)',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FinalPage(cardData: this.cards)));
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => FinalPage(cardData: this.cards)));
              },
            ),
          ],
        ),
      ),
    );
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetCardBloc>(context).add(GetCardEvent());
    } catch (e) {
      print(e);
    }
  }
}
