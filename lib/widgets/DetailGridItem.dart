import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';

class DetailGridItem extends StatefulWidget {
  final Ingredient ingredient;

  DetailGridItem({@required this.ingredient});

  @override
  State<StatefulWidget> createState() => _DetailGridItemState();
}

class _DetailGridItemState extends State<DetailGridItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      //TODO: Align by Column instead of Stack with is not efficient
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              Container(
                height: 148,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border.all(color: Colors.black45, width: .5),
                  image: DecorationImage(
                    image: widget.ingredient.image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  border: Border.all(color: Colors.black45, width: .5),
                  color: widget.ingredient.isSelected ? Colors.blueAccent : Colors.black87,
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.ingredient.name,
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: widget.ingredient.isSelected ? Icon(Icons.bookmark, color: Colors.blue) : Icon(Icons.bookmark_border),
        ),
      ],
    );
  }
}
