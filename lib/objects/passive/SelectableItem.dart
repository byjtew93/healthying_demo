import 'package:healthying/objects/passive/Bloc.dart';

abstract class SelectableItem  {
  Bloc<SelectableItem> _bloc;

  bool _isSelected = false;

  SelectableItem() {
    this._bloc = new Bloc.of(this);
  }

  bool get isSelected => _isSelected;

  Stream<SelectableItem> get stream => _bloc.stream;

  void toggleSelect() {
    _isSelected = !_isSelected;
    _bloc.update();
  }
}
