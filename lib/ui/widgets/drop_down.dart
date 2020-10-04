import 'package:flutter/material.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class Dropdown extends StatefulWidget {
  final String selectedOption;
  final List<String> options;
  final Function(int) onSelect;

  const Dropdown(
      {Key key,
      this.selectedOption = "Select organisation",
      @required this.options,
      @required this.onSelect})
      : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue;
  List<String> options = ['Select organisation'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedOption;
    options.addAll(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_balance,
            color: Colors.black45,
          ),
          UIHelper.horizontalSpaceMedium,
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              underline: Container(height: 2),
              onChanged: (String newValue) {
                setState(() => dropdownValue = newValue);
                widget.onSelect(options.indexOf(newValue) - 1);
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
