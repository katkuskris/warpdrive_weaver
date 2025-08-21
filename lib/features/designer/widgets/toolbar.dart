import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Not used in this version of Toolbar yet
// import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart'; // Not used

class ToolbarItem {
  final IconData icon;
  final String name;
  final String? label;
  final VoidCallback onPressed;

  ToolbarItem({
    required this.icon,
    required this.name,
    this.label,
    required this.onPressed,
  });
}

class Toolbar extends StatelessWidget {
  final double itemSpacing;
  final double toolbarHeight; // Added property for height

  // Made items a parameter for better reusability, but kept your default for now
  final List<ToolbarItem> items;

  Toolbar({
    super.key,
    List<ToolbarItem>? items, // Allow passing items
    this.itemSpacing = 8.0,
    this.toolbarHeight = 60.0, // Default toolbar height, make it configurable
  }) : items = items ?? [ // Use provided items or default
    ToolbarItem(
      icon: Icons.edit_outlined,
      name: "pencil",
      label: "Pencil",
      onPressed: () {
        print("Pencil pressed");
      },
    ),
    ToolbarItem(
      icon: Icons.brush_outlined,
      name: "brush",
      label: "Brush",
      onPressed: () {
        print("Brush pressed");
      },
    ),
    ToolbarItem(
      icon: Icons.highlight_alt_outlined,
      name: "select",
      label: "Select",
      onPressed: () {
        print("Select pressed");
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap the ListView in a Container with a specific height
    return Container(
      height: toolbarHeight, // <<< APPLY THE HEIGHT HERE
      // You might also want to set a background color for the toolbar area
      // color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.blueGrey,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: itemSpacing / 2), // Overall padding for the list
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: itemSpacing);
        },
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          // final toolManager = context.watch<ToolManager>(); // If you bring back selection
          // final bool isSelected = item.name == toolManager.selectedToolName;

          // You'll need to define iconSize, labelFontSize, and colors
          // or pass them as parameters if you uncomment the styling.
          const double iconSize = 24.0;
          const double labelFontSize = 10.0;
          // Color currentIconColor = isSelected ? Colors.blue : Colors.black;
          // Color currentLabelColor = isSelected ? Colors.blue : Colors.black87;
          Color currentIconColor = Theme.of(context).iconTheme.color ?? Colors.black;
          Color currentLabelColor = Theme.of(context).textTheme.bodySmall?.color ?? Colors.black87;


          return Tooltip(
            message: item.label ?? item.name,
            child: InkWell(
              onTap: item.onPressed,
              borderRadius: BorderRadius.circular(4.0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: itemSpacing, // A bit more spacing for each item
                  vertical: 4.0, // Reduce vertical padding if toolbarHeight is small
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: currentIconColor, // Apply a color
                      size: iconSize, // Apply a size
                    ),
                    if (item.label != null && item.label!.isNotEmpty) ...[
                      const SizedBox(height: 2.0), // Smaller space
                      Text(
                        item.label!,
                        style: TextStyle(
                          fontSize: labelFontSize, // Apply a font size
                          color: currentLabelColor, // Apply a color
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}