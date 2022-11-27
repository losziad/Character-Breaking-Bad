import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:characteristics/business_logic/cubit/cubit.dart';
import 'package:characteristics/business_logic/cubit/state.dart';
import 'package:characteristics/constants/colors.dart';
import 'package:characteristics/data/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key,required this.character}) : super(key: key);

  Widget buildSliverAppBar()
  {
    //Animation, Image and Name
    return SliverAppBar(
      expandedHeight: 600.0,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: TextStyle(
            color: MyColors.white,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
              character.image,
              fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  Widget characterInfo(String title, String value)
  {
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,

              )
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 16.0,
                )
            ),
          ],
        ),
    );
  }
  Widget buildDivider(double endIndent)
  {
    return Divider(
      color: MyColors.Yellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 2,
    );
  }
  Widget checkIfQuotesAreLoaded(CharacterState state)
  {
    if(state is QuotesLoaded)
    {
      return displayRandomQuoteOrEmptySpace(state);
    }
    else
      {
        return showProgressIndicator();
      }
  }
  Widget displayRandomQuoteOrEmptySpace(state)
  {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuotesIndex = Random().nextInt(quotes.length - 1);
    return Center(
      //Animation from animated text kit package
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: MyColors.white,
          shadows: [
            Shadow(
              blurRadius: 7,
              color: MyColors.Yellow,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randomQuotesIndex].quote),
          ],
        ),
      ),
    );
  }
    else
    {
      return Container();
    }
  }
  Widget showProgressIndicator()
  {
    return Center(
      child: CircularProgressIndicator(
         color: MyColors.Yellow,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.grey,
      //Animation
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo('Job : ',character.jobs.join(' / ')),
                        buildDivider(315.0),
                        characterInfo('Appeared in : ',character.category),
                        buildDivider(250.0),
                        characterInfo('Seasons : ',character.appearanceOfSeasons.join(' / ')),
                        buildDivider(280.0),
                        characterInfo('Status : ',character.status),
                        buildDivider(300.0),
                        character.betterCallSaulAppearance.isEmpty ? Container() :
                        characterInfo('Better Call Saul Seasons : ',character.betterCallSaulAppearance.join(' / ')),
                        character.betterCallSaulAppearance.isEmpty ?Container() :
                        buildDivider(150.0),
                        characterInfo('Actor/Actress : ',character.actorName),
                        buildDivider(235.0),
                        SizedBox(
                          height: 20.0,
                        ),
                        BlocBuilder<CharacterCubit, CharacterState>(
                          builder: (context, state) {
                            return checkIfQuotesAreLoaded(state);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 500.0,
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
