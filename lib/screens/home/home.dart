import 'package:flutter/material.dart';

import 'package:pokedex/screens/home/widgets/category_list.dart';

import 'package:pokedex/widgets/poke_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TrackingScrollController _scrollController;

  @override
  dispose() {
    _scrollController?.removeListener(onScroll);

    super.dispose();
  }

  @override
  initState() {
    _scrollController = TrackingScrollController();
    _scrollController.addListener(onScroll);

    super.initState();
  }

  onScroll (){}

  Widget _buildCard() {
    return PokeContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 150),
             Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),

                  child: Text(
                    "CINEMA ID",
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 30,
                      height: 0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

              ),

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child:
              Text(
                "What movies are you looking for?",
                style: TextStyle(
                  fontSize: 30,
                  height: 0.9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 30),
            CategoryList(),
          ],
        ),
      ],
    );
  }

  /*Widget _buildNews() {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28, top: 38, bottom: 22),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Pokémon News",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.indigo,
                  ),
                ),
              ],
            ),
          ),
          NewsList(),
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildCard(),

        ],
      ),
    );
  }
}
