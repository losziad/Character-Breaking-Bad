import 'package:characteristics/constants/string.dart';
import 'package:dio/dio.dart';

class CharacterApi
{
  late Dio dio;
  CharacterApi(){
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 20 * 1000,
        connectTimeout: 20 * 1000,
    );
   dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async
  {
    Response response = await dio.get('characters');
    print(response.data.toString());
    return response.data;
  }


  Future<List<dynamic>> getCharacterQuotes(String charName) async
  {
    Response response = await dio.get('quote', queryParameters: {'author' : charName});
    print(response.data.toString());
    return response.data;
  }

}