import 'package:flutter/material.dart';

enum SearchMode { user, issue, repository }

class SearchModeRadioGroup extends StatelessWidget {
  final int? selectedIndex;
  final Function(int?)? onValueChange;

  const SearchModeRadioGroup({
    Key? key,
    this.selectedIndex,
    this.onValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = selectedIndex ?? -1;
    List<String> labels = ['Users', 'Issues', 'Repositories'];

    return Column(
      children: [
        Row(
          children: labels
              .map(
                (label) => RadioItem(
                  label: label,
                  value: labels.indexOf(label),
                  groupValue: _selectedIndex,
                  onSelected: onValueChange,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  final String label;
  final int value;
  final int groupValue;
  final void Function(int?)? onSelected;

  const RadioItem({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onSelected != null && value != groupValue) {
          onSelected!(value);
        }
      },
      child: Row(
        children: [
          Radio(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.secondary;
              }
              return Colors.white;
            }),
            value: value,
            groupValue: groupValue,
            onChanged: onSelected,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
