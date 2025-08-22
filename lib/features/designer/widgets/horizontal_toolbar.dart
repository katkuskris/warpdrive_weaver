import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter

class CompactNumberInput extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  final double buttonSize; // To control the size of +/- buttons
  final double spacing;    // Spacing between elements

  const CompactNumberInput({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 99, // Sensible default max
    required this.onChanged,
    this.buttonSize = 30.0,
    this.spacing = 8.0,
  });

  @override
  State<CompactNumberInput> createState() => _CompactNumberInputState();
}

class _CompactNumberInputState extends State<CompactNumberInput> {
  late TextEditingController _controller;
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    _controller = TextEditingController(text: _currentValue.toString());
  }

  @override
  void didUpdateWidget(CompactNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _setValue(widget.initialValue);
    }
  }

  void _setValue(int newValue) {
    final clampedValue = newValue.clamp(widget.minValue, widget.maxValue);
    if (_currentValue != clampedValue) {
      setState(() {
        _currentValue = clampedValue;
        _controller.text = _currentValue.toString();
        // Move cursor to the end after programmatically changing text
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      });
      widget.onChanged(_currentValue);
    } else if (_controller.text != clampedValue.toString()) {
      // If only controller text is out of sync (e.g. user typed invalid)
      _controller.text = clampedValue.toString();
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  void _increment() {
    _setValue(_currentValue + 1);
  }

  void _decrement() {
    _setValue(_currentValue - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keep the row compact
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Minus Button
        SizedBox(
          width: widget.buttonSize,
          height: widget.buttonSize,
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: widget.buttonSize * 0.6, // Adjust icon size relative to button
            icon: const Icon(Icons.remove),
            onPressed: _currentValue > widget.minValue ? _decrement : null, // Disable if at min
            tooltip: 'Decrement',
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        SizedBox(width: widget.spacing),
        // Number Input Text Field
        SizedBox(
          width: widget.buttonSize * 1.5, // Adjust width as needed for typical numbers
          height: widget.buttonSize, // Match button height for alignment
          child: TextFormField(
            controller: _controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: (widget.buttonSize - 24) / 2), // Adjust for text vertical centering
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (value) {
              final int? typedValue = int.tryParse(value);
              if (typedValue != null) {
                if (typedValue >= widget.minValue && typedValue <= widget.maxValue) {
                  if (_currentValue != typedValue) {
                    setState(() {
                      _currentValue = typedValue;
                    });
                    widget.onChanged(_currentValue);
                  }
                }
                // If value is outside range but partially typed, allow it temporarily
                // Final clamping happens onFocusLost or next button press
              }
            },
            onEditingComplete: () {
              // This is called when user presses "done" on keyboard
              final int? typedValue = int.tryParse(_controller.text);
              if (typedValue != null) {
                _setValue(typedValue); // This will clamp and notify
              } else {
                _setValue(_currentValue); // Revert to last valid if input is garbage
              }
              FocusScope.of(context).unfocus(); // Dismiss keyboard
            },
            // It's also good to handle focus loss
            onTapOutside: (event) {
              final int? typedValue = int.tryParse(_controller.text);
              if (typedValue != null) {
                _setValue(typedValue);
              } else {
                _setValue(_currentValue); // Revert to last valid
              }
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        SizedBox(width: widget.spacing),
        // Plus Button
        SizedBox(
          width: widget.buttonSize,
          height: widget.buttonSize,
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: widget.buttonSize * 0.6,
            icon: const Icon(Icons.add),
            onPressed: _currentValue < widget.maxValue ? _increment : null, // Disable if at max
            tooltip: 'Increment',
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}
