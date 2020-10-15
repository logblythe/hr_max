import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String selectedOption;
  final List<String> options;
  final Function(int) onSelect;

  const Dropdown(
      {Key key,
      this.selectedOption,
      @required this.options,
      @required this.onSelect})
      : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedOption;
    options.addAll(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        contentPadding: const EdgeInsets.all(16),
        prefixIcon: Icon(Icons.account_balance, color: Colors.black45),
      ),
      hint: Text("Select your organisation"),
      value: dropdownValue,
      validator: (value) =>
          value == null ? "Required" : null,
      onChanged: (String newValue) {
        setState(() => dropdownValue = newValue);
        widget.onSelect(options.indexOf(newValue));
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
