import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class FileSelectFormField extends StatefulWidget {
  final bool submitting;

  final String? label;
  final String? hint;

  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const FileSelectFormField({
    super.key,
    required this.submitting,
    this.label,
    this.hint,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<FileSelectFormField> createState() => _FileSelectFormFieldState();
}

class _FileSelectFormFieldState extends State<FileSelectFormField> {
  String? _filepath;

  void _openFile() async {
    final file = await openFile();
    if (file == null) {
      return;
    }
    setState(() {
      _filepath = file.path;
      if (widget.onChanged != null) {
        widget.onChanged!(file.path);
      }
    });
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
                controller: TextEditingController(text: _filepath),
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
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
              ),
            ),
            IconButton(
              onPressed: widget.submitting ? null : () => _openFile(),
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
