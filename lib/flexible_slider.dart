library flexible_slider;

import 'package:flexible_slider/arrays.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlexibleSlider extends StatefulWidget {
  /// Max value of the slider
  /// By Default [50.0]
  final double max;

  /// Minimum value of the slider
  /// By Default [0.0]
  final double min;

  /// Nombre of digits displayed after decimal point when changing the slider
  /// By Default [1]
  final int fractionDigits;

  ///The color to use for the portion of the slider track that is active.
  final Color? activeColor;

  ///The number of discrete divisions of the slider.
  final int? divisions;

  ///Indicate whether the textfield is enabled
  /// By Default [true]
  final bool enabled;

  /// The decoration to show around the text field
  /// By default, set a grey background to the text field .
  late InputDecoration? textDecoration;

  /// Indicate the display position of the textfield vis-a-vis with the slider
  /// ```Dart
  /// {
  ///   defaultPosition,
  ///   reversedPosition,
  /// }
  /// ```
  final Position position;

  /// The Direction of the widget children .
  /// ```Dart
  ///{
  ///horizontal,
  /// vertical,
  ///}
  ///  ```
  /// Defaults to [Direction.horizontal].
  final Direction direction;

  /// Callback invoked when changing slider or updation the textfield .
  /// Takes as a parameter a double value
  /// Required in all constructers
  final Function(double) onValueChanged;

  final double? initialSliderValue;


  FlexibleSlider({
    Key? key,
    this.max = 50.0,
    this.min = 0.0,
    this.fractionDigits = 1,
    this.activeColor,
    this.enabled = true,
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
    this.direction = Direction.horizontal,
    this.position = Position.defaultPosition,
    this.divisions,
    this.initialSliderValue,
    required this.onValueChanged,
  }) : super(key: key){
    if(initialSliderValue != null){
      assert(initialSliderValue! >= min  && initialSliderValue! <= max );
    }
  }

  FlexibleSlider.primary({
    Key? key,
    this.max = 50.0,
    this.min = 0.0,
    this.fractionDigits = 1,
    this.activeColor,
    this.enabled = true,
    this.direction = Direction.horizontal,
    this.position = Position.defaultPosition,
    this.divisions,
    this.initialSliderValue,
    required this.onValueChanged,
  }) : super(key: key) {
    if(initialSliderValue != null){
      assert(initialSliderValue! >= min  && initialSliderValue! <= max );
    }
    textDecoration = const InputDecoration(
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
    );
  }

  @override
  State<FlexibleSlider> createState() => _FlexibleSliderState();
}

class _FlexibleSliderState extends State<FlexibleSlider> {
  late double _currentSliderValue = widget.initialSliderValue ?? widget.min;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = _currentSliderValue.toStringAsFixed(
      widget.fractionDigits,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Direction.horizontal == widget.direction
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Position.defaultPosition == widget.position
                ? horizontalList()
                : horizontalList().reversed.toList(),
          )
        : Column(
            children: Position.defaultPosition == widget.position
                ? verticalList()
                : verticalList().reversed.toList(),
          );
  }

  void onSliderChanged(double value) {
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

  List<Widget> verticalList() {
    return [
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
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: TextField(
          enabled: widget.enabled,
          decoration: widget.textDecoration,
          keyboardType: TextInputType.number,
          controller: textEditingController,
          onChanged: onTextChanged,
        ),
      ),
    ];
  }

  List<Widget> horizontalList() {
    return [
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
          child: TextField(
            enabled: widget.enabled,
            decoration: widget.textDecoration,
            keyboardType: TextInputType.number,
            controller: textEditingController,
            onChanged: onTextChanged,
          ),
        ),
      ),
    ];
  }
}
