import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/presentation/designer.dart';


class MainAppLayout extends StatefulWidget { // Changed to StatefulWidget
  const MainAppLayout({super.key});

  @override
  State<MainAppLayout> createState() => _MainAppLayoutState();
}

class _MainAppLayoutState extends State<MainAppLayout> { // Create State
  int _selectedIndex = 0; // To keep track of the selected rail item

  // Your existing _buildTieUpGrid method (or make it part of this State class)
  // Ensure it uses context.watch or Consumer appropriately if it needs to be reactive


  // Placeholder for your other page/content widgets
  Widget _buildContentForSelectedIndex(int index) {
    switch (index) {
      case 0: // Corresponds to the first NavigationRailDestination
        return Padding( // Keep your original padding for the content area
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
const Designer()
              ],
            ),
          ),
        );
      case 1:
        return const Center(child: Text('Settings Page Content')); // Placeholder
      case 2:
        return const Center(child: Text('Profile Page Content')); // Placeholder
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Weaving App'), // More general title now
      ),
      body: Row( // Main body is now a Row
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected, // Or .all / .none
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.grid_on_outlined),
                selectedIcon: Icon(Icons.grid_on),
                label: Text('Editor'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
            ],
            // You can add more styling like:
            // backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            // indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            // elevation: 4,
            // extended: true, // If you want labels to always be visible and more space
          ),
          const VerticalDivider(thickness: 1, width: 1), // Optional separator
          // Main content area, expands to fill remaining space
          Expanded(
            child: _buildContentForSelectedIndex(_selectedIndex),
          ),
        ],
      ),
      // Your FAB might need to be contextually shown/hidden or change its action
      // based on _selectedIndex, or removed if actions are in the rail destinations.
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final wifNotifier = context.read<WifNotifier>();
      //     wifNotifier.weavingSectionNotifier.incrementShaftCount();
      //   },
      //   tooltip: 'Increment Shafts',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}