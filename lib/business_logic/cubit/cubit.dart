import 'package:characteristics/business_logic/cubit/state.dart';
import 'package:characteristics/data/model/character.dart';
import 'package:characteristics/data/model/quotes.dart';
import 'package:characteristics/data/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharacterState>
{
  final CharactersRepository charactersRepository;
   List<Character> characters=[];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  List<Character> getAllCharacters()
  {
    charactersRepository.getAllCharacters().then((characters) {
    emit(CharacterLoaded(characters));
    this.characters = characters;
    });
    return characters;
  }

 void getQuotes(String charName)
  {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}