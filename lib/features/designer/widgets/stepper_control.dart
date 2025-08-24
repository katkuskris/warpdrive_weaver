import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters

class StepperControl extends StatefulWidget {
  final String label; // The label to display (e.g., "Treadle Count", "Shaft Count")
  final int currentValue; // The current value to display and work with
  final int minValue = 0;
  final int maxValue = 99;
  final VoidCallback? onIncrement; // Callback for + button
  final VoidCallback? onDecrement; // Callback for - button
  final ValueChanged<int> onValueChanged; // Callback for when text field value is submitted
  final double itemSize = 20;
  final bool isIncrementDisabled; // Optional: To control plus button state externally
  final bool isDecrementDisabled; // Optional: To control minus button state externally

  const StepperControl({
    super.key,
    required this.label,
    required this.currentValue,
    required this.onIncrement,
    required this.onDecrement,
    required this.onValueChanged,
    this.isIncrementDisabled = false,
    this.isDecrementDisabled = false,
  });

  @override
  State<StepperControl> createState() => _StepperControlState();
}

class _StepperControlState extends State<StepperControl> {
  late TextEditingController _textController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();

    _textController.text = widget.currentValue.toString();
    _focusNode.addListener(_onFocusChange);
  }

  // This lifecycle method is called when the widget's properties change.
  // We need to update the text controller if the currentValue from the parent changes.
  @override
  void didUpdateWidget(StepperControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentValue != oldWidget.currentValue) {
      // Only update if not currently focused, to avoid disrupting user input.
      // Or, be more sophisticated if needed (e.g., if external change should always override).
      if (!_focusNode.hasFocus) {
        final currentValueStr = widget.currentValue.toString();
        if (_textController.text != currentValueStr) {
          _textController.text = currentValueStr;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        }
      }
    }
  }

  void _onFocusChange() {
    if (!mounted) return;
    if (!_focusNode.hasFocus) {
      _submitValueFromTextField();
    }
  }

  void _submitValueFromTextField() {
    if (!mounted) return;
    final String currentText = _textController.text;
    int? newValue = int.tryParse(currentText);

    if (newValue != null) {
      newValue = newValue.clamp(widget.minValue, widget.maxValue);

    } else {
      // If parsing fails, revert text field to current widget value
      _textController.text = widget.currentValue.toString();
    }
    // Ensure selection is at the end after potential reversion
    _textController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textController.text.length),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine button states based on props or currentValue
    final bool actualDecrementDisabled = widget.isDecrementDisabled || widget.currentValue <= widget.minValue;
    final bool actualIncrementDisabled = widget.isIncrementDisabled || widget.currentValue >= widget.maxValue;

    return Column(
      mainAxisSize: MainAxisSize.min, // Keep column compact
      crossAxisAlignment: CrossAxisAlignment.center, // Center the label
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: widget.itemSize,
              height: widget.itemSize,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove),
                iconSize: widget.itemSize,
                tooltip: 'Decrement ${widget.label}',
                onPressed: actualDecrementDisabled ? null : widget.onDecrement,
              ),
            ),
            const SizedBox(width: 0),
            SizedBox(
              width: widget.itemSize * 2.5,
              height: widget.itemSize * 1.5, // You might need to adjust height if isDense changes visuals
              child: TextFormField(
                controller: _textController,
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center, // Good for centering text vertically
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  isDense: true, // Make it compact, often better for borderless
                  contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0), // Adjust padding as needed
                  border: InputBorder.none,         // Removes the default border/underline
                  focusedBorder: InputBorder.none,  // Removes border when field is focused
                  enabledBorder: InputBorder.none,  // Removes border when field is enabled (and not focused)
                  errorBorder: InputBorder.none,    // Removes border when field has an error
                  disabledBorder: InputBorder.none, // Removes border when field is disabled
                  // You might want to set a subtle background color if it's borderless
                  // to make it visually distinct, or ensure its container provides contrast.
                  // filled: true,
                  // fillColor: Colors.grey[200],
                ),
                onFieldSubmitted: (value) {
                  _submitValueFromTextField();
                },
                // Optional: Add a cursor color if the default is hard to see without a border
                // cursorColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 0),
            SizedBox(
              width: widget.itemSize,
              height: widget.itemSize,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.add),
                iconSize: widget.itemSize,
                tooltip: 'Increment ${widget.label}',
                onPressed: actualIncrementDisabled ? null : widget.onIncrement,
              ),
            ),
          ],
        ),// Space between stepper and label
        Text(
          widget.label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}