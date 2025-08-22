import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:provider/provider.dart'; // Assuming you use Provider
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_object_section_notifiers/weaving_section_notifier.dart';

class StepperControl extends StatefulWidget {
  final int minValue;
  final int maxValue;
  // Optional: if you want to control button/text field size
  final double itemSize;

  const StepperControl({
    super.key,
    this.minValue = 0,
    this.maxValue = 99,
    this.itemSize = 20.0, // Default size for buttons and text field height
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

    // Initialize text field with the current value from the provider
    // and listen for provider changes to update the text field.
    final notifier = Provider.of<WifNotifier>(context, listen: false);
    _textController.text = notifier.currentWif.weavingSection?.treadles.toString() ?? '0';

    notifier.addListener(_handleNotifierChange);

    _focusNode.addListener(_onFocusChange);
  }

  void _handleNotifierChange() {
    if (!mounted) return;
    final notifier = Provider.of<WifNotifier>(context, listen: false);
    final notifierValueStr = notifier.currentWif.weavingSection?.treadles.toString() ?? '0';
    if (_textController.text != notifierValueStr) {
      _textController.text = notifierValueStr;
      // Optionally move cursor to the end
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }
  }

  void _onFocusChange() {
    if (!mounted) return;
    if (!_focusNode.hasFocus) {
      // When focus is lost, submit the current text field value
      _submitValueFromTextField();
    }
  }

  void _submitValueFromTextField() {
    if (!mounted) return;
    final notifier = Provider.of<WifNotifier>(context, listen: false);
    final wifNotifier = Provider.of<WifNotifier>(context, listen: false);
    final String currentText = _textController.text;
    int? newValue = int.tryParse(currentText);

    if (newValue != null) {
      // Clamp the value to min/max if needed
      newValue = newValue.clamp(widget.minValue, widget.maxValue);
      notifier.weavingSectionNotifier.setTreadleCount(newValue); // Update the provider
    } else {
      // If parsing fails, revert text field to current provider value
      _textController.text = wifNotifier.currentWif.weavingSection?.treadles.toString() ?? '0';
    }
  }

  @override
  void dispose() {
    // Clean up
    final notifier = Provider.of<WifNotifier>(context, listen: false);
    notifier.removeListener(_handleNotifierChange);
    _textController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider for changes to update UI elements like button states
    final notifier = context.watch<WifNotifier>();
    final wifNotifier = context.watch<WifNotifier>();

    return Column(
      children: [ Row(
        mainAxisSize: MainAxisSize.min, // Keep it compact
        children: [
          // Minus Button
          SizedBox(
            width: widget.itemSize,
            height: widget.itemSize,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.remove_circle_outline),
              iconSize: widget.itemSize * 0.7,
              tooltip: 'Decrement',
              onPressed: (wifNotifier.currentWif.weavingSection?.treadles ?? widget.minValue) > widget.minValue
                  ? () => notifier.weavingSectionNotifier.decrementTreadleCount()
                  : null, // Disable if at min value
            ),
          ),
          const SizedBox(width: 4), // Spacing

          // Text Entry
          SizedBox(
            width: widget.itemSize * 1.5, // Make text field a bit wider
            height: widget.itemSize,
            child: TextFormField(
              controller: _textController,
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                isDense: true, // Makes it more compact
                contentPadding: EdgeInsets.symmetric(vertical: 0.0), // Adjust padding
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) {
                // Called when user presses "done" on keyboard
                _submitValueFromTextField();
              },
            ),
          ),
          const SizedBox(width: 4), // Spacing

          // Plus Button
          SizedBox(
            width: widget.itemSize,
            height: widget.itemSize,
            child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.add_circle_outline),
                iconSize: widget.itemSize * 0.7,
                tooltip: 'Increment',
                onPressed: (wifNotifier.currentWif.weavingSection?.treadles ?? widget.minValue) < widget.maxValue
                    ? () => notifier.weavingSectionNotifier.incrementTreadleCount()
                    : null
            ),
          ),
        ],
      ),
        const Text(
          "Treadle Count",
          style: TextStyle(fontSize: 12), // Adjust style as needed
        ),
      ]
      );
  }
}
