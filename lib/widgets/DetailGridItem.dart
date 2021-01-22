import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/objects/passive/SelectableItem.dart';

class DetailGridItem extends StatefulWidget {
  final Ingredient ingredient;

  DetailGridItem({@required this.ingredient});

  @override
  State<StatefulWidget> createState() => _DetailGridItemState();
}

class _DetailGridItemState extends State<DetailGridItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SelectableItem>(
        stream: widget.ingredient.stream,
        builder: (_, snap) {
          if (snap.hasError)
            return Center(child: Icon(Icons.error, color: Colors.red));
          else if (!snap.hasData) return Center(child: CupertinoActivityIndicator());
          return Card(
            color: Colors.transparent,
            elevation: 0,
            child: Column(
              children: [
                if (snap.hasData)
                  Container(
                    height: 148,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      border: Border.all(color: Colors.black45, width: .5),
                      image: DecorationImage(
                        image: widget.ingredient.image.image,
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                    ),
                  )
                else
                  CupertinoActivityIndicator(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    border: Border.all(color: Colors.black45, width: .5),
                    color: snap.hasData && snap.data.isSelected ? Colors.blueAccent : Colors.black87,
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
          );
        });
  }
}
