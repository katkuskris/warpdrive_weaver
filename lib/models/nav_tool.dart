import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/widgets/shaft_count_editor.dart'; // Adjust path
import 'package:warp_drive_weaver/features/designer/widgets/tie_up_grid.dart'; // Adjust path

// Define an enum or constants for your page indices if you prefer
enum AppPage { editor, settings, profile }

class MainAppScaffoldWithNav extends StatefulWidget {
  const MainAppScaffoldWithNav({super.key});

  @override
  State<MainAppScaffoldWithNav> createState() => _MainAppScaffoldWithNavState();
}

class _MainAppScaffoldWithNavState extends State<MainAppScaffoldWithNav> {
  int _selectedIndex = AppPage.editor.index; // Default to editor

  // This method builds the content based on the selected index.
  // For larger apps, each case would likely return a dedicated Page widget.
  Widget _buildPageContent(int index) {
    // You could also pass the WifNotifier or other relevant notifiers down
    // to these page widgets if they need them, or they can access them via Provider.
    switch (AppPage.values[index]) {
      case AppPage.editor:
        return const EditorPageContent(); // Extracted widget for editor content
      case AppPage.settings:
        return const Center(child: Text('Settings Page Content')); // Placeholder
      case AppPage.profile:
        return const Center(child: Text('Profile Page Content')); // Placeholder
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The AppBar title could also change based on _selectedIndex if desired
        title: Text('Weaving App - ${AppPage.values[_selectedIndex].name.toUpperCase()}'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(Icons.grid_on_outlined),
                selectedIcon: const Icon(Icons.grid_on),
                label: Text(AppPage.editor.name),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: Text(AppPage.settings.name),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                label: Text(AppPage.profile.name),
              ),
            ],
            // Optional: Add styling from your theme
            // backgroundColor: Theme.of(context).colorScheme.surface,
            // elevation: 4,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _buildPageContent(_selectedIndex),
          ),
        ],
      ),
    );
  }
}

// --- Define your page content widgets (can be in their own files) ---

class EditorPageContent extends StatelessWidget {
  const EditorPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // This widget can access WifNotifier via context.watch if needed
    // e.g., final wifNotifier = context.watch<WifNotifier>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center( // Or SingleChildScrollView, or a more complex layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const ShaftCountEditor(),
            const SizedBox(height: 16),
            const Text(
              "Tie-Up Grid:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const TieUpGrid(), // Assumes TieUpGridWidget handles its own provider needs
            // Add more editor components here
            // const Expanded(child: SomeOtherEditorComponent()), // If needed
          ],
        ),
      ),
    );
  }
}
