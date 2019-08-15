import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PokeContainer extends StatelessWidget {
  const PokeContainer({
    Key key,
    @required this.children,
    this.height,
    this.decoration,
    this.appBar = false,
  }) : super(key: key);

  final bool appBar;
  final List<Widget> children;
  final Decoration decoration;
  final double height;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //final pokeLeft = -(screenSize.width * 0.15);
    final pokeSize = screenSize.width * 0.66;
    final pokeTop1 = -(screenSize.width * 0.130);
    final pokeTop = -(screenSize.width * 0.154);
    //final pokeBottom = -(screenSize.width * 0.230);
    final pokeRight = -(screenSize.width * 0.23);
    final appBarTop = pokeSize / 2 + pokeTop - IconTheme.of(context).size / 2;

    return Container(
      height: screenSize.height *0.89,
      width: screenSize.width,
      decoration: decoration,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: pokeTop1,
            right: pokeRight,
            child: Image.asset(
              "assets/images/logo1.png",
              width: pokeSize,
              height: pokeSize,
              color: Color(0xFF303943).withOpacity(0.10),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (appBar)
                Padding(
                  padding: EdgeInsets.only(left: 26, right: 26, top: appBarTop),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.close),
                        onTap: Navigator.of(context).pop,
                      ),
                    ],
                  ),
                ),
              if (children != null) ...children,
            ],
          ),
         // Positioned(
         //   bottom: pokeBottom,
         //   left: pokeLeft,
         //   child: Image.asset(
         //     "assets/images/logo1.png",
         //     width: pokeSize,
         //     height: pokeSize,
         //     color: Color(0xFF303943).withOpacity(0.10),
         //   ),
         // )
        ],
      ),
    );
  }
}
