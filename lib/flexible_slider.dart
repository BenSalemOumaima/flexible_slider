library flexible_slider;

import 'package:flexible_slider/arrays.dart';
import 'package:flutter/material.dart';

class FlexibleSlider extends StatefulWidget {
  final double max;
  final double min;
  final int fractionDigits;
  final Color? activeColor;
  final int? divisions;
  final bool? enabled;
  final InputDecoration? textDecoration;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Direction direction;
  final Function(double) onValueChanged;
  const FlexibleSlider({
    Key? key,
    this.max = 50.0,
    this.min = 0.0,
    this.fractionDigits = 1,
    this.activeColor,
    this.enabled,
    this.textDecoration,
    this.direction = Direction.horizontal,
    required this.divisions,
    // this.textLabel,
    required this.onValueChanged,
  }) : super(key: key);

  const FlexibleSlider.stable({
    Key? key,
    this.max = 50.0,
    this.min = 0.0,
    this.fractionDigits = 1,
    this.activeColor,
    this.enabled,
    this.direction = Direction.horizontal,
    this.textDecoration = const InputDecoration(
      contentPadding: EdgeInsets.all(8),
      filled: true,
      fillColor: Colors.black12,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
    ),
    required this.divisions,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<FlexibleSlider> createState() => _FlexibleSliderState();
}

class _FlexibleSliderState extends State<FlexibleSlider> {
  late double _currentSliderValue = widget.min;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //todo
    return Direction.horizontal == widget.direction
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(widget.min.toStringAsFixed(0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(widget.max.toStringAsFixed(0)),
                        ),
                      ],
                    ),
                    Slider(
                      mouseCursor: MouseCursor.defer,
                      value: _currentSliderValue,
                      max: widget.max,
                      min: widget.min,
                      divisions: widget.divisions,
                      activeColor: widget.activeColor,
                      onChanged: onSliderChanged,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      enabled: widget.enabled,
                      decoration: widget.textDecoration,
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                      onChanged: onTextChanged,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(widget.min.toStringAsFixed(0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(widget.max.toStringAsFixed(0)),
                      ),
                    ],
                  ),
                  Slider(
                    mouseCursor: MouseCursor.uncontrolled,
                    value: _currentSliderValue,
                    max: widget.max,
                    min: widget.min,
                    divisions: widget.divisions,
                    activeColor: widget.activeColor,
                    onChanged: onSliderChanged,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    enabled: widget.enabled,
                    decoration: widget.textDecoration,
                    keyboardType: TextInputType.number,
                    controller: textEditingController,
                    onChanged: onTextChanged,
                  ),
                ),
              ),
            ],
          );
  }

  void onSliderChanged(double value) {
    //todo
    textEditingController.text = value.toStringAsFixed(
      widget.fractionDigits,
    );
    setState(() {
      _currentSliderValue = value;
    });
    widget.onValueChanged.call(value);
  }

  void onTextChanged(String value) {
    textEditingController.text = value;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    setState(() {
      var newValue = double.tryParse(value) ?? 0.0;
      if (newValue > widget.max) {
        _currentSliderValue = widget.max;
      } else if (newValue < widget.min) {
        _currentSliderValue = widget.min;
      } else {
        _currentSliderValue = newValue;
      }
      widget.onValueChanged.call(newValue);
    });
  }
}
