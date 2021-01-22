import 'package:flutter/material.dart';

class Tool {
  final String name;
  final ToolCategory category;

  Tool({this.name, this.category = ToolCategory.NONE});

  static Tool fromMap(Map<String, dynamic> data) => data == null || data.isEmpty
      ? null
      : Tool(
          name: data['name'],
          category: stringToToolCategory(data['category']),
        );

  Map<String, dynamic> toMap() => {
        'name': name,
        'category': category.toCorrectString(),
      };
}

enum ToolCategory { NONE, SLICE, OVEN, STOVE, MIXER, MILL }

extension ToolCategoryExtension on ToolCategory {
  String toCorrectString() => this.toString().substring(13);

  Color get color {
    switch (this) {
      case ToolCategory.SLICE:
        return Colors.blueGrey;
      case ToolCategory.OVEN:
        return Colors.orange;
      case ToolCategory.STOVE:
        return Colors.redAccent;
      case ToolCategory.MIXER:
        return Colors.deepPurpleAccent;
      case ToolCategory.MILL:
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}

ToolCategory stringToToolCategory(String category) {
  switch (category.toUpperCase()) {
    case "SLICE":
      return ToolCategory.SLICE;
    case "OVEN":
      return ToolCategory.OVEN;
    case "STOVE":
      return ToolCategory.STOVE;
    case "MIXER":
      return ToolCategory.MIXER;
    case "MILL":
      return ToolCategory.MILL;
    default:
      return ToolCategory.NONE;
  }
}
