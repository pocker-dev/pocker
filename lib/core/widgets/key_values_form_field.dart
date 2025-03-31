import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class KeyValuePair {
  String key;
  String value;

  KeyValuePair.empty()
      : key = '',
        value = '';

  KeyValuePair.from({required this.key, required this.value});

  bool get isEmpty {
    return key.isEmpty && value.isEmpty;
  }
}

class KeyValuesFormField extends StatefulWidget {
  final bool submitting;

  final String? label;
  final String? keyHint;
  final String? valueHint;
  final String? addButtonText;

  final ValueChanged<List<KeyValuePair>>? onChanged;
  final FormFieldSetter<List<KeyValuePair>>? onSaved;

  const KeyValuesFormField({
    super.key,
    required this.submitting,
    this.label,
    this.keyHint,
    this.valueHint,
    this.addButtonText,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<KeyValuesFormField> createState() => _KeyValuesFormFieldState();
}

class _KeyValuesFormFieldState extends State<KeyValuesFormField> {
  List<KeyValuePair> _arguments = [];

  @override
  void initState() {
    super.initState();
    if (widget.addButtonText == null) {
      _arguments.add(KeyValuePair.empty());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null)
          SelectableText(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (widget.addButtonText != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _arguments.add(KeyValuePair.empty());
                  });
                },
                label: Text(widget.addButtonText!),
                icon: Icon(
                  Symbols.add_circle,
                  fill: 1,
                ),
              ),
            ],
          ),
        for (final (index, item) in _arguments.indexed)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget.submitting,
                  decoration: InputDecoration(
                    hintText: widget.keyHint,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 5.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: TextEditingController(text: item.key),
                  onChanged: (val) {
                    setState(() {
                      item.key = val;
                    });
                  },
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextFormField(
                  readOnly: widget.submitting,
                  decoration: InputDecoration(
                    hintText: widget.valueHint,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 5.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: TextEditingController(text: item.value),
                  onChanged: (val) {
                    setState(() {
                      item.value = val;
                    });
                  },
                ),
              ),
              if (index != _arguments.length - 1 ||
                  widget.addButtonText != null)
                IconButton(
                  onPressed: widget.submitting ||
                          (_arguments.length == 1 &&
                              widget.addButtonText == null &&
                              item.isEmpty)
                      ? null
                      : () {
                          setState(() {
                            _arguments.removeAt(index);
                          });
                        },
                  icon: Icon(
                    fill: 1,
                    size: 16.0,
                    Symbols.cancel,
                    color: _arguments.length == 1 &&
                            widget.addButtonText == null &&
                            item.isEmpty
                        ? null
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              if (index == _arguments.length - 1 &&
                  widget.addButtonText == null)
                IconButton(
                  onPressed: widget.submitting
                      ? null
                      : () {
                          setState(() {
                            _arguments.add(KeyValuePair.empty());
                          });
                        },
                  icon: Icon(
                    fill: 1,
                    size: 16.0,
                    Symbols.add_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
