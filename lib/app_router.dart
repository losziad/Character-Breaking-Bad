import 'package:characteristics/business_logic/cubit/cubit.dart';
import 'package:characteristics/constants/string.dart';
import 'package:characteristics/data/api/character_api.dart';
import 'package:characteristics/data/model/character.dart';
import 'package:characteristics/data/repository/character_repository.dart';
import 'package:characteristics/presentations/screens/characteristics_details_screen.dart';
import 'package:characteristics/presentations/screens/characteristics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter{

  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRouter()
  {
    charactersRepository = CharactersRepository(CharacterApi());
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings)
  {
    switch(settings.name)
    {
      case characterScreen:
      return MaterialPageRoute(builder: (_)=>BlocProvider(
        create: (BuildContext context)=>CharacterCubit(
            charactersRepository,
        ),
          child: CharacteristicsScreen(),
      ),
      );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_)=>BlocProvider(
            create: (BuildContext context) => CharacterCubit(charactersRepository),
            child: CharacterDetailsScreen(
              character: character,
            ),
           ),
        );
    }
  }

}