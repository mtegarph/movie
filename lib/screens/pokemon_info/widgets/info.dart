import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/animated_fade.dart';
import 'package:pokedex/widgets/animated_rotation.dart';
import 'package:pokedex/widgets/animated_slide.dart';
import 'package:pokedex/widgets/pokemon_type.dart';
import 'package:provider/provider.dart';

import 'decoration_box.dart';

class PokemonOverallInfo extends StatefulWidget {
  @override
  _PokemonOverallInfoState createState() => _PokemonOverallInfoState();
}

class _PokemonOverallInfoState extends State<PokemonOverallInfo> with TickerProviderStateMixin {
  static const double _appBarHorizontalPadding = 28.0;
  static const double _appBarTopPadding = 60.0;
  static const double _appBarBottomPadding = 22.0;

  int _currentPage = 0;
  PageController _pageController;
  AnimationController _slideController;
  AnimationController _rotateController;
  GlobalKey _currentTextKey = GlobalKey();
  GlobalKey _targetTextKey = GlobalKey();

  double textDiffTop = 0.0;
  double textDiffLeft = 0.0;

  @override
  void initState() {
    _slideController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _slideController.forward();

    _rotateController = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    _rotateController.repeat();

    _pageController = PageController(viewportFraction: 0.6);
    _pageController.addListener(() {
      int next = _pageController.page.round();

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox targetTextBox = _targetTextKey.currentContext.findRenderObject();
      final Offset targetTextPosition = targetTextBox.localToGlobal(Offset.zero);

      final RenderBox currentTextBox = _currentTextKey.currentContext.findRenderObject();
      final Offset currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      textDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      textDiffTop = targetTextPosition.dy - currentTextPosition.dy;
    });

    super.initState();
  }

  @override
  dispose() {
    _slideController.dispose();
    _rotateController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: _appBarHorizontalPadding,
        right: _appBarHorizontalPadding,
        top: _appBarTopPadding,
        bottom: _appBarBottomPadding,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Icon(Icons.close, color: Colors.white),
                onTap: Navigator.of(context).pop,
              ),
              Icon(Icons.favorite_border, color: Colors.white),
            ],
          ),
          // This widget just sit here for easily calculate the new position of
          // the pokemon name when the card scroll up
          Opacity(
            opacity: 0.0,
            child: Text(
              "Beautiful boy",
              key: _targetTextKey,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonName() {
    final cardScrollController = Provider.of<AnimationController>(context);


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: cardScrollController,
            builder: (context, child) {
              final double value = cardScrollController.value ?? 0.0;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Hero(
                  tag: "Beautiful Boy",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Beautiful Boy",
                      key: _currentTextKey,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 36 - (36 - 22) * value,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _buildPokemonTypes() {
    final cardScrollController = Provider.of<AnimationController>(context);
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    return AnimatedFade(
      animation: fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "BulbasaurGrass",
                  child: PokemonType("Drama", large: true),
                ),
                SizedBox(width: 7),

              ],
            ),
            AnimatedSlide(
              animation: _slideController,
              child: Text(
                "ABOUT MOVIE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonSlider(BuildContext context) {

    final cardScrollController = Provider.of<AnimationController>(context);
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: cardScrollController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final List<String> gambar = [
      "pikachu.png",
      "ivysaur.png",
      "blastoise.png",

    ];

    return AnimatedFade(
      animation: fadeAnimation,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: screenHeight * 0.24,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedRotation(
                animation: _rotateController,
                child: Image.asset(
                  "assets/images/logo1.png",//muter muter
                  width: screenHeight * 0.24,
                  height: screenHeight * 0.24,
                  color: Colors.white.withOpacity(0.14),
                ),
              ),
            ),
            PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: gambar.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Hero(
                      tag: gambar[index] ,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeOutQuint,
                        padding: EdgeInsets.only(
                          top: _currentPage == index ? 0 : screenHeight * 0.04,
                          bottom: _currentPage == index ? 0 : screenHeight * 0.04,
                        ),
                        child: Image.asset(
                          "assets/images/${gambar[index]}",
                          width: screenHeight * 0.28,
                          height: screenHeight * 0.28,
                          alignment: Alignment.bottomCenter,
                          color: _currentPage == index ? null : Color(0xFF28A889),
                        ),
                      ),
                    ),

                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardScrollController = Provider.of<AnimationController>(context);
    final dottedAnimation = Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final pokeSize = screenWidth * 0.448;

    final pokeTop = -(pokeSize / 2 - (IconTheme.of(context).size / 2 + _appBarTopPadding));
    final pokeRight = -(pokeSize / 2 - (IconTheme.of(context).size / 2 + _appBarHorizontalPadding));

    return Stack(
      children: [
        Positioned(
          top: pokeTop,
          right: pokeRight,
          child: AnimatedFade(
            animation: cardScrollController,
            child: AnimatedRotation(
              animation: _rotateController,
              child: Image.asset(
                "assets/images/logo2.png",//muter muter
                width: pokeSize,
                height: pokeSize,
                color: Colors.white.withOpacity(0.26),
              ),
            ),
          ),
        ),
        Positioned(
          top: -screenHeight * 0.055,
          left: -screenHeight * 0.055,
          child: DecorationBox(),
        ),
        Positioned(
          top: 4,
          left: screenHeight * 0.3,
          child: AnimatedFade(
            animation: dottedAnimation,
            child: Image.asset(
              "assets/images/dotted.png",
              width: screenHeight * 0.07,
              height: screenHeight * 0.07 * 0.54,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            _buildAppBar(),
            SizedBox(height: 9),
            _buildPokemonName(),
            SizedBox(height: 9),
            _buildPokemonTypes(),
            SizedBox(height: 25),
            _buildPokemonSlider(context),
          ],
        ),
      ],
    );
  }
}
