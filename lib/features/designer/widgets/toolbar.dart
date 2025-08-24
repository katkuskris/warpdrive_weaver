import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Not used in this version of Toolbar yet
// import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart'; // Not used
class ToolbarItemData {
  final IconData icon;
  final String name;
  final String? label;
  final VoidCallback onPressed;

  ToolbarItemData({
    required this.icon,
    required this.name,
    this.label,
    required this.onPressed,
  });
}

// Optional: A dedicated widget to render ToolbarItemData
// This promotes separation of concerns.
class ToolbarActionItem extends StatelessWidget {
  final ToolbarItemData item;
  final double iconSize;
  final double labelFontSize;
  final double itemSpacing; // For consistent padding

  const ToolbarActionItem({
    super.key,
    required this.item,
    this.iconSize = 24.0,
    this.labelFontSize = 10.0,
    this.itemSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    // You can add selection logic here if needed, perhaps by comparing item.name
    // with a value from a Provider or another state management solution.
    // final bool isSelected = ... ;
    // Color currentIconColor = isSelected ? Colors.blue : Theme.of(context).iconTheme.color ?? Colors.black;
    // Color currentLabelColor = isSelected ? Colors.blue : Theme.of(context).textTheme.bodySmall?.color ?? Colors.black87;
    Color currentIconColor = Theme.of(context).iconTheme.color ?? Colors.black;
    Color currentLabelColor =
        Theme.of(context).textTheme.bodySmall?.color ?? Colors.black87;

    return Tooltip(
      message: item.label ?? item.name,
      child: InkWell(
        onTap: item.onPressed,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: itemSpacing,
            vertical: 4.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Important for fitting in the toolbar
            children: [
              Icon(
                item.icon,
                color: currentIconColor,
                size: iconSize,
              ),
              if (item.label != null && item.label!.isNotEmpty) ...[
                const SizedBox(height: 2.0),
                Text(
                  item.label!,
                  style: TextStyle(
                    fontSize: labelFontSize,
                    color: currentLabelColor,
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
  }
}

class Toolbar extends StatelessWidget {
  final double itemSpacing;
  final double toolbarHeight;
  final List<Widget> children; // <<< ACCEPTS A LIST OF WIDGETS

  const Toolbar({
    super.key,
    required this.children, // Now requires a list of widgets
    this.itemSpacing = 16.0,
    this.toolbarHeight = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: toolbarHeight,
      // color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.blueGrey[100], // Example color
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Or another appropriate color
        border: Border( // Optional: add a bottom border like an AppBar
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
            horizontal: itemSpacing), // Adjust padding as needed
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: itemSpacing);
        },
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          // Each child is already a widget, so just return it.
          // Wrap in a Center or Align if specific alignment within the toolbar height is needed.
          return Center(child: children[index]);
        },
      ),
    );
  }
}