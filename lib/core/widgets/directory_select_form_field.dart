import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DirectorySelectFormField extends StatefulWidget {
  final bool submitting;

  final String? label;
  final String? hint;
  final String? initValue;

  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const DirectorySelectFormField({
    super.key,
    required this.submitting,
    this.label,
    this.hint,
    this.initValue,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<DirectorySelectFormField> createState() =>
      _DirectorySelectFormFieldState();
}

class _DirectorySelectFormFieldState extends State<DirectorySelectFormField> {
  String? _directory;

  Future<void> _getDirectory() async {
    final String? path = await getDirectoryPath();
    if (path == null) {
      return;
    }
    setState(() {
      _directory = path;
      if (widget.onChanged != null) {
        widget.onChanged!(path);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DirectorySelectFormField oldWidget) {
    if (widget.initValue != oldWidget.initValue) {
      setState(() {
        _directory = widget.initValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null)
          SelectableText(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _directory),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 5.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'form_empty_error'.tr();
                  }
                  return null;
                },
                onSaved: widget.onSaved,
                onChanged: widget.onChanged,
              ),
            ),
            IconButton(
              onPressed: widget.submitting ? null : () => _getDirectory(),
              icon: Icon(
                fill: 1,
                size: 16.0,
                Symbols.folder_open,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
