import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class FileSaveFormField extends StatefulWidget {
  final bool submitting;

  final String? label;
  final String? hint;
  final String? suggestedName;

  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const FileSaveFormField({
    super.key,
    required this.submitting,
    this.label,
    this.hint,
    this.suggestedName,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<FileSaveFormField> createState() => _FileSaveFormFieldState();
}

class _FileSaveFormFieldState extends State<FileSaveFormField> {
  String? _filepath;

  Future<void> _saveFile() async {
    final FileSaveLocation? result =
        await getSaveLocation(suggestedName: widget.suggestedName);
    if (result == null) {
      return;
    }
    setState(() {
      _filepath = result.path;
      if (widget.onChanged != null) {
        widget.onChanged!(result.path);
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
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
              ),
            ),
            FilledButton(
              onPressed: widget.submitting ? null : () => _saveFile(),
              child: Text('browse'.tr()),
            ),
          ],
        ),
      ],
    );
  }
}
