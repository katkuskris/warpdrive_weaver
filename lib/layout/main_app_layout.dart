import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/presentation/designer.dart';

class MainAppLayout extends StatefulWidget {
  const MainAppLayout({super.key});

  @override
  State<MainAppLayout> createState() => _MainAppLayoutState();
}

class _MainAppLayoutState extends State<MainAppLayout> {
  int _selectedIndex = 0; // To keep track of the selected rail item
  Widget _buildContentForSelectedIndex(int index) {
    switch (index) {
      case 0: // Corresponds to the first NavigationRailDestination
      // Remove the unnecessary Center and Column.
      // Let DesignerScreen directly occupy the space given by the Expanded widget in the body.
        return const Padding(
          padding: EdgeInsets.all(16.0), // You can keep padding if you like
          child: DesignerScreen(),
        );
      case 1:
        return const Center(
          child: Text('Settings Page Content'),
        ); // Placeholder
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
      body: Row(
        // Main body is now a Row
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all, // Or .all / .none
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.grid_4x4),
                selectedIcon: Icon(Icons.grid_4x4),
                label: Text('Designer'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.folder_outlined),
                selectedIcon: Icon(Icons.folder_outlined),
                label: Text('My Drafts'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings_outlined),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1), // Optional separator
          // Main content area, expands to fill remaining space
          Expanded(child: _buildContentForSelectedIndex(_selectedIndex)),
        ],
      ),
    );
  }
}
