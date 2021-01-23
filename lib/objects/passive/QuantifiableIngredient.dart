import 'package:healthying/objects/passive/Bloc.dart';

abstract class QuantifiableIngredient  {
  Bloc<QuantifiableIngredient> _bloc;

  int _quantity = 0;

  QuantifiableIngredient() {
    this._bloc = new Bloc.of(this);
  }

  bool get isSelected => _quantity > 0;
  int get quantity => _quantity;

  Stream<QuantifiableIngredient> get stream => _bloc.stream;

  void select() {
    _quantity += 1;
    _bloc.update();
  }
  
  void unselect() {
    _quantity = 0;
    _bloc.update();
  }
}
