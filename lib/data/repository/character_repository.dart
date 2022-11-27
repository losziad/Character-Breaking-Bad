import 'package:characteristics/data/api/character_api.dart';
import 'package:characteristics/data/model/character.dart';
import 'package:characteristics/data/model/quotes.dart';

class CharactersRepository{
  final CharacterApi characterApi;

  CharactersRepository(this.characterApi);
  Future<List<Character>> getAllCharacters() async
  {
    final character = await characterApi.getAllCharacters();
    return character.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async
  {
    final quotes = await characterApi.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }
}