import 'package:characteristics/business_logic/cubit/cubit.dart';
import 'package:characteristics/business_logic/cubit/state.dart';
import 'package:characteristics/constants/colors.dart';
import 'package:characteristics/data/model/character.dart';
import 'package:characteristics/presentations/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacteristicsScreen extends StatefulWidget {

  @override
  State<CharacteristicsScreen> createState() => _CharacteristicsScreenState();
}

class _CharacteristicsScreenState extends State<CharacteristicsScreen> {
  late List<Character> allCharacters;
  //List for search
  late List<Character> searchedForCharacter;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField()
  {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        hintText: 'find a character ....',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.grey,
          fontSize: 18.0,
        ),
      ),
      style: TextStyle(
        color: MyColors.grey,
        fontSize: 18.0,
      ),
      onChanged: (searchedCharacter)
      {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }
 void addSearchedForItemsToSearchedList(String searchedCharacter)
  {
    searchedForCharacter = allCharacters.where((character) => character.name.toLowerCase().startsWith(searchedCharacter)).toList();
    setState(() {

    });
  }
  List<Widget> _buildAppBarActions()
  {
    if(_isSearching)
      {
         return [
           IconButton(
             onPressed: ()
             {
               _clearSearch();
               Navigator.pop(context);
             },
             icon: Icon(
             Icons.clear,
             color: MyColors.grey,
           ),
           ),
         ];
      }
    else
      {
         return [
           IconButton(
               onPressed: _startSearch,
               icon: Icon(
                 Icons.search,
                 color: MyColors.grey,
               ),
           ),
         ];
      }
  }
 void _startSearch()
  {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching),);
    setState(() {
      _isSearching = true;
    });
  }
  void _stopSearching()
  {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }
   void _clearSearch()
   {
    setState(() {
      _searchTextController.clear();
    });
  }
  @override
   void initState()
   {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }
   Widget buildBlocWidget()
   {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).character;
          return buildLoadedIsWidgets();
        }
        else {
              return showLoadingIndicator();
        }
      },
    );
  }
   Widget showLoadingIndicator()
   {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.Yellow,
      ),
    );
   }
   Widget buildLoadedIsWidgets()
   {
     return SingleChildScrollView(
       child: Container(
         color: MyColors.grey,
         child: Column(
           children: [
             buildCharactersList(),
           ],
         ),
       ),
     );
   }
  @override
  Widget buildCharactersList()
  {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty? allCharacters.length : searchedForCharacter.length,
        itemBuilder: (context, index){
          return CharacterItem(
            character: _searchTextController.text.isEmpty? allCharacters[index] : searchedForCharacter[index],
          );
        },
    );
  }
  Widget _buildAppBarTitle()
  {
    return Text(
      'Characters',
      style: TextStyle(
        color: MyColors.grey,
      ),
    );
  }
  Widget buildNoInternetWidget()
  {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Can\'t connect..check internet',
              style: TextStyle(
                fontSize: 20.0,
                color: MyColors.grey,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Image.asset('assets/images/download.png')
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.Yellow,
        leading: _isSearching ? BackButton(
          color: MyColors.grey,
        ) : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
        )
            {
              final bool connected = connectivity != ConnectivityResult.none;
              if(connected)
                {
                  return buildBlocWidget();
                }
              else
                {
                  return buildNoInternetWidget();
                }
            },
        child: showLoadingIndicator(),
      ),
    );
  }
}
