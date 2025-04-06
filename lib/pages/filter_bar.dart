import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String? selectedBgColor;
  final String? selectedTextColor;
  final String? selectedType;
  final String? selectedSortOption;
  final double minContrast;
  final double maxContrast;
  final Set<String> bgColors;
  final Set<String> textColors;
  final Set<String> types;
  final TextEditingController minContrastController;
  final TextEditingController maxContrastController;
  final ValueChanged<String?> onBgColorChanged;
  final ValueChanged<String?> onTextColorChanged;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String?> onSortOptionChanged;
  final VoidCallback onResetFilters;
  final ValueChanged<RangeValues> onContrastChanged;

  const FilterBar({
    super.key,
    required this.selectedBgColor,
    required this.selectedTextColor,
    required this.selectedType,
    required this.selectedSortOption,
    required this.minContrast,
    required this.maxContrast,
    required this.bgColors,
    required this.textColors,
    required this.types,
    required this.minContrastController,
    required this.maxContrastController,
    required this.onBgColorChanged,
    required this.onTextColorChanged,
    required this.onTypeChanged,
    required this.onSortOptionChanged,
    required this.onResetFilters,
    required this.onContrastChanged,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode minContrastFocusNode = FocusNode();
    final FocusNode maxContrastFocusNode = FocusNode();

    minContrastFocusNode.addListener(() {
      if (!minContrastFocusNode.hasFocus) {
        final parsedValue = double.tryParse(minContrastController.text);
        if (parsedValue != null && parsedValue >= 1.00 && parsedValue <= maxContrast) {
          onContrastChanged(RangeValues(parsedValue, maxContrast));
        } else {
          minContrastController.text = minContrast.toStringAsFixed(2);
        }
      }
    });

    maxContrastFocusNode.addListener(() {
      if (!maxContrastFocusNode.hasFocus) {
        final parsedValue = double.tryParse(maxContrastController.text);
        if (parsedValue != null && parsedValue <= 21.00 && parsedValue >= minContrast) {
          onContrastChanged(RangeValues(minContrast, parsedValue));
        } else {
          maxContrastController.text = maxContrast.toStringAsFixed(2);
        }
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 16,
        runSpacing: 8,
        children: [
          SizedBox(width: 200, child: _buildDropdown('Background Color', selectedBgColor, bgColors, onBgColorChanged)),
          SizedBox(width: 200, child: _buildDropdown('Text Color', selectedTextColor, textColors, onTextColorChanged)),
          SizedBox(width: 200, child: _buildDropdown('Type', selectedType, types, onTypeChanged)),
          SizedBox(width: 200, child: _buildSortDropdown()),
          SizedBox(
            width: 416,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Contrast',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Row(
                children: [
                  Expanded(child: RangeSlider(min: 1.00, max: 21.00, values: RangeValues(minContrast, maxContrast), onChanged: onContrastChanged)),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: minContrastController,
                      focusNode: minContrastFocusNode,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Min', labelStyle: TextStyle(fontSize: 10)),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: maxContrastController,
                      focusNode: maxContrastFocusNode,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Max', labelStyle: TextStyle(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 56)),
              onPressed: onResetFilters,
              child: Text('Reset Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue, Set<String> options, ValueChanged<String?> onChanged) {
    final sortedOptions = options.toList()..sort();
    sortedOptions.insert(0, 'All');
    return SizedBox(
      width: 200,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            items:
                sortedOptions.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return SizedBox(
      width: 200,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Sort By',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedSortOption,
            items: ['Random', 'Background Color', 'Text Color'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
            onChanged: onSortOptionChanged,
          ),
        ),
      ),
    );
  }
}
