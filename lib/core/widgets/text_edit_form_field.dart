import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextEditFormField extends StatefulWidget {
  final bool submitting;

  final String? label;
  final String? hint;
  final String? initialValue;

  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const TextEditFormField({
    super.key,
    required this.submitting,
    this.initialValue,
    this.label,
    this.hint,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<TextEditFormField> createState() => _TextEditFormFieldState();
}

class _TextEditFormFieldState extends State<TextEditFormField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
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
        TextFormField(
          readOnly: widget.submitting,
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hint,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'form_empty_error'.tr();
            }
            return null;
          },
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
        ),
      ],
    );
  }
}
