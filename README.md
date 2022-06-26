# Flexible Slider
A new easy way to create slider with editable textfield with realtime value changing .

## Features

- Display slider with textfield
- Customize slider appearance 
- Customize textfield appearance (Decoration)
- Customize textfield and slider position
- Support RTL and LTR  layout orientation

## Installation

In order to add **Flexible slider** to your project add this line to your `pubspec.yaml` file
```yaml
dependencies:
	flexible_slider:  0.0.1
```

## Attributes
```dart
/// Max value of the slider
/// By Default [50.0]
final  double max;

/// Minimum value of the slider
/// By Default [0.0]
final  double min;
  
/// Nombre of digits displayed after decimal point when changing the slider
/// By Default [1]
final  int fractionDigits;
  
///The color to use for the portion of the slider track that is active.
final  Color? activeColor;
  
///The number of discrete divisions of the slider.
final  int? divisions;

///Indicate whether the textfield is enabled
/// By Default [true]
final  bool enabled;  

/// The decoration to show around the text field
/// By default, set a grey background to the text field .
late  InputDecoration? textDecoration;
 
/// Indicate the display position of the textfield vis-a-vis with the slider
///{
/// defaultPosition,
/// reversedPosition,
/// }
final  Position position;
 
/// The Direction of the widget children .
///{
///horizontal,
/// vertical,
///}
/// Defaults to [Direction.horizontal].
final  Direction direction;
 
/// Callback invoked when changing slider or updation the textfield .
/// Takes as a parameter a double value
/// Required in all constructers
final  Function(double) onValueChanged;
```


## Implementation
Simple integration :
```dart
FlexibleSlider(
	divisions:  4,
	onValueChanged: (value) {
		print(value);
	},
),
```
Flexible slider with different direction :
```dart
FlexibleSlider(
	divisions:  5,
	direction:  Direction.vertical,
	onValueChanged: (value) {
		print(value);
	},
),
```
Flexible slider with different position :
```dart
FlexibleSlider(
	divisions:  5,
	direction:  Direction.vertical,
	position:  Position.reversedPosition,
	fractionDigits:  6,
	onValueChanged: (value) {
		print(value);
	},
),
```

## Contribution

The project is open source, and you can contribute to it [repository link](https://github.com/BenSalemOumaima/flexible_slider)

## Contributors

<a href="https://github.com/BenSalemOumaima/flexible_slider/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=BenSalemOumaima/flexible_slider" />
</a>

