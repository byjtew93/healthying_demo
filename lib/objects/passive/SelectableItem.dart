abstract class SelectableItem {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  void toggleSelect() => _isSelected = !_isSelected;
}
