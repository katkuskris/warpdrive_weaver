import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart'; // Adjust path as needed

class ShaftCountEditor extends StatefulWidget {
  const ShaftCountEditor({super.key});

  @override
  State<ShaftCountEditor> createState() => _ShaftCountEditorState();
}

class _ShaftCountEditorState extends State<ShaftCountEditor> {
  // TextEditingController to manage the TextFormField's state and initial value
  late TextEditingController _shaftCountController;
  final _formKey = GlobalKey<FormState>(); // For TextFormField validation

  @override
  void initState() {
    super.initState();
    _shaftCountController = TextEditingController();
    // Initialize the controller with the current value from the notifier
    // Listen to changes in the notifier to update the text field if the value
    // is changed externally (e.g., by increment/decrement buttons).
    final wifNotifier = Provider.of<WifNotifier>(context, listen: false);
    _updateControllerWithValue(wifNotifier.currentWif.weavingSection?.shafts);

    wifNotifier.addListener(_handleWifChanges);
  }

  void _handleWifChanges() {
    // This listener ensures the text field updates if the shaft count
    // is changed by the +/- buttons or programmatically elsewhere.
    final wifNotifier = Provider.of<WifNotifier>(context, listen: false);
    final currentShaftCountInNotifier = wifNotifier.currentWif.weavingSection?.shafts;
    final currentShaftCountInField = int.tryParse(_shaftCountController.text);

    if (currentShaftCountInNotifier != null &&
        currentShaftCountInNotifier != currentShaftCountInField) {
      _updateControllerWithValue(currentShaftCountInNotifier);
    }
  }

  void _updateControllerWithValue(int? count) {
    _shaftCountController.text = count?.toString() ?? '0';
  }


  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    Provider.of<WifNotifier>(context, listen: false).removeListener(_handleWifChanges);
    _shaftCountController.dispose();
    super.dispose();
  }

  void _submitShaftCount(String value) {
    if (_formKey.currentState!.validate()) { // Trigger validation
      final newShaftCount = int.tryParse(value);
      if (newShaftCount != null) { // Already validated by form validator
        context
            .read<WifNotifier>()
            .weavingSectionNotifier
            .setShaftCount(newShaftCount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using a Consumer here to get the initial value and for the display text,
    // but the TextFormField will use its own controller for real-time updates.
    final wifNotifier = context.watch<WifNotifier>();
    final int currentShaftCount = wifNotifier.currentWif.weavingSection?.shafts ?? 0;

    // This ensures that if the widget rebuilds and the controller wasn't updated
    // by the listener yet (e.g., due to immediate state change elsewhere),
    // it still reflects the most recent value from the notifier upon rebuild.
    // However, the listener (_handleWifChanges) is the primary way it stays in sync.
    if (_shaftCountController.text != currentShaftCount.toString()) {
      _shaftCountController.text = currentShaftCount.toString();
      // Move cursor to the end after updating text
      _shaftCountController.selection = TextSelection.fromPosition(
          TextPosition(offset: _shaftCountController.text.length));
    }


    return Form( // Wrap with a Form widget for validation
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // So the column doesn't take excessive space
        children: <Widget>[
          const Text(
            'Current number of shafts:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '$currentShaftCount', // Display directly from notifier for reactivity
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  wifNotifier.weavingSectionNotifier.decrementShaftCount();
                  // The listener will update the _shaftCountController
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  wifNotifier.weavingSectionNotifier.incrementShaftCount();
                  // The listener will update the _shaftCountController
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Set Shaft Count Directly:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: _shaftCountController, // Use the controller
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g., 8',
              ),
              onFieldSubmitted: _submitShaftCount,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter';
                }
                final number = int.tryParse(value);
                if (number == null) {
                  return 'Invalid';
                }
                if (number < 1) {
                  return 'Min 1';
                }
                if (number > 48) { // Example max
                  return 'Max 48';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }
}