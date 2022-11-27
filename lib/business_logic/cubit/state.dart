import 'package:characteristics/data/model/character.dart';
import 'package:characteristics/data/model/quotes.dart';

abstract class CharacterState{}

class CharacterInitial extends CharacterState{}

class CharacterLoaded extends CharacterState{
  final List<Character> character;

  CharacterLoaded(this.character);
}

class QuotesLoaded extends CharacterState{
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}