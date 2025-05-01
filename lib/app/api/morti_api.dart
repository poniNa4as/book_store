import 'package:book_store/app/utilites/character.dart';
import 'package:dio/dio.dart';

class MortiApi {
   
   final Dio dio = Dio();

  Future<List<Character>> fetchCharacter () async  {
    try {
       final Response response =  await dio.get('https://rickandmortyapi.com/api/character');
       final List<dynamic> result = response.data['results'];
       return result.map((item) => Character.fromJson(item)).toList();

    } catch (e) {
      throw Exception('Error: $e');
      
    }
  }
}