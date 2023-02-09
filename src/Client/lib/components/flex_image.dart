
import 'package:flutter/material.dart';
import '../design/radius.dart';

///
/// Praktisch ein Image, der:
///  - seine Größe flexibel anpasst
///  - beim Tippen die gegebene Funktion f auslöst
///  - ein Button ist
///
/// Durch Gesturedetector sind auch weitere Gesten auffassbar (Doppeltippen usw.).
/// Dies läßt sich durch Vererbung beliebig implementieren.
/// Außerdem wäre es möglich den Icons einen Hintergrund zu geben, da sie sich in
/// einen Container befinden.
///
/// Weitere Funktionen:
///   - croppen zum Square
///   - automatisches Abrunden der Ecken (mit Optionen)
///   - Beschreibung mit verschiedenen Optionen
///   -
///
///

class FlexibleImage extends StatefulWidget {
  final String imagePath;
  final void Function() f;
  final String description;
  double containerPadding;
  bool showDescription;
  Color textColor;
  double textSize;
  bool cropToSquare;
  BorderRadius? radius;

  FlexibleImage(this.imagePath, this.f,
      {this.containerPadding = 40,
      this.description = "",
      this.showDescription = false,
      this.textColor = Colors.black,
      this.textSize = 20,
      this.cropToSquare = true,
      this.radius,
      Key? key})
      : super(key: key);

  @override
  State<FlexibleImage> createState() => _FlexibleImageState();
}

class _FlexibleImageState extends State<FlexibleImage> {
  @override
  Widget build(BuildContext context) {
    widget.radius ??= CustomRadius.getStandartBorderRadius(context);
    var widgets = <Widget>[
      ClipRRect(
        child: widget.cropToSquare
            ? AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: AssetImage(widget.imagePath),
                  )),
                ),
              )
            : Image.asset(
                widget.imagePath,
                filterQuality: FilterQuality.medium,
              ),
        borderRadius: widget.radius,
      )
    ];
    if (widget.showDescription) {
      widgets.add(Container(
        child: Text(
          widget.description,
          style: TextStyle(color: widget.textColor, fontSize: widget.textSize),
          maxLines: 1,
        ),
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.width / 50, 0, 0),
      ));
    }
    Widget content = Container(
        padding: EdgeInsets.all(widget.containerPadding),
        child: GestureDetector(
          child: Center(
              child: Expanded(
                  child: Column(
            children: widgets,
          ))),
          onTap: () {
            widget.f();
          },
        ));
    return content;
  }
}
