import 'package:flutter/material.dart';

class ViewModeChoiceGroup extends StatelessWidget {
  final int? selectedIndex;
  final Function(int)? onValueChange;

  const ViewModeChoiceGroup({
    Key? key,
    this.selectedIndex,
    this.onValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = selectedIndex ?? -1;
    List<String> viewMode = ['Lazy Loading', 'With Index'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: viewMode
            .map<Widget>(
              (mode) => ChoiceItem(
                index: viewMode.indexOf(mode),
                selectedIndex: _selectedIndex,
                label: mode,
                onSelected: onValueChange,
              ),
            )
            .toList()
          ..insert(1, const SizedBox(width: 16)),
      ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  final String label;
  final int index;
  final int selectedIndex;
  final Function(int)? onSelected;

  const ChoiceItem({
    Key? key,
    required this.label,
    required this.index,
    required this.selectedIndex,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selected = index == selectedIndex;

    return ChoiceChip(
      label: Text(label),
      selectedColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      pressElevation: 0,
      side: _selected ? BorderSide.none : const BorderSide(color: Colors.white),
      labelStyle: TextStyle(
        color: _selected ? Colors.grey[800] : Colors.white,
      ),
      selected: _selected,
      onSelected: (val) {
        if (onSelected != null && index != selectedIndex) {
          onSelected!(index);
        }
      },
    );
  }
}
