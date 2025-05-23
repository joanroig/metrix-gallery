import 'package:flutter/material.dart';

import '../utils/css_colors.dart';

class FilterBar extends StatefulWidget {
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
  FilterBarState createState() => FilterBarState();
}

class FilterBarState extends State<FilterBar> {
  bool _isExpanded = false;

  late FocusNode minContrastFocusNode;
  late FocusNode maxContrastFocusNode;

  @override
  void initState() {
    super.initState();
    minContrastFocusNode = FocusNode();
    maxContrastFocusNode = FocusNode();

    minContrastFocusNode.addListener(() {
      if (!minContrastFocusNode.hasFocus) {
        final parsedValue = double.tryParse(widget.minContrastController.text);
        if (parsedValue != null && parsedValue >= 1.00 && parsedValue <= widget.maxContrast) {
          widget.onContrastChanged(RangeValues(parsedValue, widget.maxContrast));
        } else {
          widget.minContrastController.text = widget.minContrast.toStringAsFixed(2);
        }
      }
    });

    maxContrastFocusNode.addListener(() {
      if (!maxContrastFocusNode.hasFocus) {
        final parsedValue = double.tryParse(widget.maxContrastController.text);
        if (parsedValue != null && parsedValue <= 21.00 && parsedValue >= widget.minContrast) {
          widget.onContrastChanged(RangeValues(widget.minContrast, parsedValue));
        } else {
          widget.maxContrastController.text = widget.maxContrast.toStringAsFixed(2);
        }
      }
    });
  }

  @override
  void dispose() {
    minContrastFocusNode.dispose();
    maxContrastFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            elevation: 0,
            dividerColor: Colors.transparent,
            expandedHeaderPadding: EdgeInsets.zero,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Filters', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                    leading: Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: _buildDropdown('Background Color', widget.selectedBgColor, widget.bgColors, widget.onBgColorChanged),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _buildDropdown('Text Color', widget.selectedTextColor, widget.textColors, widget.onTextColorChanged),
                      ),
                      SizedBox(width: double.infinity, child: _buildDropdown('Type', widget.selectedType, widget.types, widget.onTypeChanged)),
                      SizedBox(width: double.infinity, child: _buildSortDropdown()),
                      SizedBox(width: double.infinity, child: _buildContrastSlider()),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 56),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                          onPressed: widget.onResetFilters,
                          child: Text('Reset Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                isExpanded: _isExpanded,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: [
          SizedBox(width: 220, child: _buildDropdown('Background Color', widget.selectedBgColor, widget.bgColors, widget.onBgColorChanged)),
          SizedBox(width: 220, child: _buildDropdown('Text Color', widget.selectedTextColor, widget.textColors, widget.onTextColorChanged)),
          SizedBox(width: 220, child: _buildDropdown('Type', widget.selectedType, widget.types, widget.onTypeChanged)),
          SizedBox(width: 220, child: _buildSortDropdown()),
          SizedBox(width: 456, child: _buildContrastSlider()),
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 56),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: widget.onResetFilters,
              child: Text('Reset Filters', style: TextStyle(fontWeight: FontWeight.bold)),
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
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          // labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // Clear focus when tapping outside
          },
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              items:
                  sortedOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Row(
                        children: [
                          if (label != 'Type' && option != 'All') ...[
                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: CSSColors.getColorByName(option) ?? Colors.transparent,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                          Text(option),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                FocusScope.of(context).requestFocus(FocusNode()); // Clear focus after selection
                onChanged(value);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return SizedBox(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Sort By',
          // labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: widget.selectedSortOption,
            items: ['Random', 'Background Color', 'Text Color'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
            onChanged: (value) {
              FocusScope.of(context).requestFocus(FocusNode()); // Clear focus after selection
              widget.onSortOptionChanged(value);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContrastSlider() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Contrast',
        // labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Row(
        children: [
          Expanded(
            child: RangeSlider(
              min: 1.00,
              max: 21.00,
              values: RangeValues(widget.minContrast, widget.maxContrast),
              onChanged: (RangeValues values) {
                // Validate values to ensure they stay within bounds
                double start = values.start.clamp(1.00, 21.00);
                double end = values.end.clamp(1.00, 21.00);

                // Ensure start is never greater than end
                if (start > end) {
                  start = end;
                }

                widget.onContrastChanged(RangeValues(start, end));
              },
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: TextField(
              controller: widget.minContrastController,
              focusNode: minContrastFocusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Min',
                labelStyle: TextStyle(fontSize: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onSubmitted: (value) {
                final parsedValue = double.tryParse(value);
                if (parsedValue != null && parsedValue >= 1.00 && parsedValue <= widget.maxContrast) {
                  widget.onContrastChanged(RangeValues(parsedValue, widget.maxContrast));
                } else {
                  widget.minContrastController.text = widget.minContrast.toStringAsFixed(2);
                }
              },
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: TextField(
              controller: widget.maxContrastController,
              focusNode: maxContrastFocusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Max',
                labelStyle: TextStyle(fontSize: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onSubmitted: (value) {
                final parsedValue = double.tryParse(value);
                if (parsedValue != null && parsedValue <= 21.00 && parsedValue >= widget.minContrast) {
                  widget.onContrastChanged(RangeValues(widget.minContrast, parsedValue));
                } else {
                  widget.maxContrastController.text = widget.maxContrast.toStringAsFixed(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
