import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/passive/Bloc.dart';
import 'package:healthying/objects/passive/Global.dart';

import 'Tool.dart';

class RecipeStep {
  // Bloc
  Bloc<RecipeStep> _bloc;

  Bloc<RecipeStep> get bloc => _bloc;

  // Const
  Color get _optionalColor => Colors.yellowAccent.withOpacity(.5);

  // Variables
  final ToolCategory toolCategory;
  final bool optional;
  final String instruction;
  final int heat;
  final int duration;
  final String until;
  final String breakpoint;
  final String breakpointText;

  // Dynamic
  Color _containerColor = Colors.lightBlueAccent;
  String _heatLabel;
  Color _heatColor;

  // Builders
  RecipeStep(
      {this.toolCategory, this.optional, this.instruction, this.heat, this.duration, this.until, this.breakpoint, this.breakpointText}) {
    _setStoveHeatAttributes();
  }

  static RecipeStep fromMap(Map<String, dynamic> data) => (data == null || data.isEmpty)
      ? null
      : RecipeStep(
          toolCategory: data.containsKey('toolCategory') ? stringToToolCategory(data['toolCategory']) : ToolCategory.NONE,
          optional: data.containsKey('optional'),
          instruction: data['instruction'],
          heat: data.containsKey('heat') ? int.tryParse(data['heat']) : DISABLED,
          duration: data.containsKey('duration') ? int.tryParse(data['duration']) : DISABLED,
          until: data.containsKey('until') ? data['until'] : null,
          breakpoint: data.containsKey('breakpoint') ? data['breakpoint'] : null,
          breakpointText: data.containsKey('breakpointText') ? data['breakpointText'] : null,
        );

  // FUNCTIONS
  Map<String, dynamic> toMap() => {
        'toolCategory': toolCategory.toCorrectString(),
        'optional': optional,
        'instruction': instruction,
        'heat': heat,
        'duration': duration,
        'until': until,
        'breakpoint': breakpoint,
        'breakpointText': breakpointText,
      };

  void _setStoveHeatAttributes() {
    switch (heat) {
      case 1:
        _heatLabel = "LOW";
        _heatColor = Colors.lightBlue;
        break;
      case 2:
        _heatLabel = "MEDIUM";
        _heatColor = Colors.orangeAccent;
        break;
      case 3:
        _heatLabel = "HIGH";
        _heatColor = Colors.red;
        break;
      case 4:
        _heatLabel = "MAXIMUM";
        _heatColor = Colors.red[900];
        break;
      default:
        _heatLabel = "VERY LOW";
        _heatColor = Colors.lightBlueAccent;
        break;
    }
  }

  Widget get _labelOfType {
    Widget label = Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        border: Border.all(color: Colors.black, width: .25),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        toolCategory.toCorrectString(),
        style: TextStyle(color: Colors.black),
      ),
    );
    if (toolCategory != ToolCategory.OVEN && toolCategory != ToolCategory.STOVE) return label;
    Widget heat = Container(
      decoration: BoxDecoration(
        color: _heatColor,
        border: Border.all(color: Colors.black, width: .25),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        _heatLabel,
        style: TextStyle(color: Colors.white),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [label, heat],
    );
  }

  Container _optionalContainer({@required Widget child}) {
    return Container(
      color: _optionalColor,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Optional"),
          child,
        ],
      ),
    );
  }

  Widget get card {
    Widget child = Container(
      decoration: BoxDecoration(color: _containerColor),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_labelOfType, Text(instruction)],
      ),
    );
    if (optional) child = _optionalContainer(child: child);
    if (toolCategory == ToolCategory.OVEN && duration != null)
      return Container(
        child: Row(
          children: [
            child,
            Container(
              color: Colors.black,
              child: Text(
                "$duration MIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    return child;
  }

  @override
  String toString() {
    return 'RecipeStep{toolCategory: $toolCategory, optional: $optional, instruction: $instruction, heat: $heat, duration: $duration, until: $until, breakpoint: $breakpoint, breakpointText: $breakpointText, _containerColor: $_containerColor, _heatLabel: $_heatLabel, _heatColor: $_heatColor}';
  }
}
