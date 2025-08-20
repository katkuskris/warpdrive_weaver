import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart'; // Adjust path as needed

class ShaftCountEditor extends StatefulWidget {
  const ShaftCountEditor({super.key});

  @override
  State<ShaftCountEditor> createState() => _ShaftCountEditorState();
}

class _ShaftCountEditorState extends State<ShaftCountEditor> {
  late TextEditingController _shaftCountController;
  final _formKey = GlobalKey<FormState>();
  WifNotifier? _wifNotifier; // Store the notifier instance

  @override
  void initState() {
    super.initState();
    _shaftCountController = TextEditingController();
    // Initial value setting is fine here if you ensure _wifNotifier is available
    // OR delay it to didChangeDependencies after _wifNotifier is set.
    // For simplicity with current structure, let's keep it here but ensure
    // _wifNotifier is obtained first in didChangeDependencies.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtain the WifNotifier instance here.
    // This method is called after initState and when dependencies change.
    final newWifNotifier = Provider.of<WifNotifier>(context, listen: false);

    // If the notifier instance has changed or if it's the first time,
    // update the listener and the initial controller value.
    if (newWifNotifier != _wifNotifier) {
      // Remove listener from the old notifier, if any
      _wifNotifier?.removeListener(_handleWifChanges);

      _wifNotifier = newWifNotifier; // Store the new instance

      // Add listener to the new notifier
      _wifNotifier?.addListener(_handleWifChanges);

      // Initialize/update the controller with the current value from the (new) notifier
      // This ensures that if the widget is rebuilt and gets a new notifier instance,
      // or on the first build, the text field is correctly initialized.
      _updateControllerWithValue(_wifNotifier?.currentWif.weavingSection?.shafts);
    }
  }

  void _handleWifChanges() {
    // Crucial: Check if the widget is still mounted before accessing context or state.
    if (!mounted) {
      return;
    }

    // Now it's safer to access the stored _wifNotifier instance.
    // No need to call Provider.of(context) here anymore.
    final currentShaftCountInNotifier = _wifNotifier?.currentWif.weavingSection?.shafts;
    final currentShaftCountInField = int.tryParse(_shaftCountController.text);

    if (currentShaftCountInNotifier != null &&
        currentShaftCountInNotifier != currentShaftCountInField) {
      _updateControllerWithValue(currentShaftCountInNotifier);
    }
  }

  void _updateControllerWithValue(int? count) {
    if (!mounted) return; // Also good practice here for safety
    final newText = count?.toString() ?? '0';
    if (_shaftCountController.text != newText) {
      _shaftCountController.text = newText;
      // Optionally, only update selection if the widget is focused or text actually changed
      // to avoid unnecessary cursor jumps if the update is redundant.
      // _shaftCountController.selection = TextSelection.fromPosition(
      //     TextPosition(offset: _shaftCountController.text.length));
    }
  }

  @override
  void dispose() {
    // Remove the listener from the stored notifier instance
    _wifNotifier?.removeListener(_handleWifChanges);
    _shaftCountController.dispose();
    super.dispose();
  }

  void _submitShaftCount(String value) {
    if (!mounted) return; // Good practice for safety
    if (_formKey.currentState!.validate()) {
      final newShaftCount = int.tryParse(value);
      if (newShaftCount != null) {
        // Use context.read here as it's a one-time action triggered by user.
        // Or use the stored _wifNotifier if you prefer.
        context
            .read<WifNotifier>()
            .weavingSectionNotifier
            .setShaftCount(newShaftCount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.watch is fine here for rebuilding when WifNotifier changes.
    final wifNotifierFromBuild = context.watch<WifNotifier>();
    final int currentShaftCount = wifNotifierFromBuild.currentWif.weavingSection?.shafts ?? 0;

    // Synchronize controller if build happens and listener hasn't caught up or for initial build
    // This check should ideally be less frequent if _handleWifChanges and initial setup
    // in didChangeDependencies are robust.
    final currentControllerText = currentShaftCount.toString();
    if (_shaftCountController.text != currentControllerText) {
      _shaftCountController.text = currentControllerText;
      _shaftCountController.selection = TextSelection.fromPosition(
          TextPosition(offset: _shaftCountController.text.length));
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Current number of shafts:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '$currentShaftCount',
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
                  // Use the notifier instance obtained from context.watch or context.read
                  // for actions.
                  wifNotifierFromBuild.weavingSectionNotifier.decrementShaftCount();
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  wifNotifierFromBuild.weavingSectionNotifier.incrementShaftCount();
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
              controller: _shaftCountController,
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
                if (number > 48) {
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

