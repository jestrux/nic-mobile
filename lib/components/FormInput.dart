// ignore_for_file: prefer_is_empty, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nic/utils.dart';

const Color grey200 = Color(0XFFEEEEEE);
const Color black = Color(0XFF000000);
const EdgeInsets formInputPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 10);

class FormInput extends StatefulWidget {
  final EdgeInsets padding;
  final String? label;
  final String? error;
  final String hint;
  final String? value;
  final int minLines;
  final int maxLines;
  final double borderWidth;
  final Color borderColor;
  final Color bgColor;
  final Color labelColor;
  final Color textColor;
  final Color? hintColor;
  final TextAlign textAlign;
  final double fontSize;
  final double iconSize;
  final TextInputType? type;
  final bool readOnly;
  final IconData? icon;
  final int? maxLength;
  final bool obscureText;
  final bool money;
  final bool? autoFocus;
  final Widget? leading;
  final FocusNode? focusNode;
  final Function? onClear;
  final Function? onChange;
  final Function? onClick;

  const FormInput({
    Key? key,
    this.padding = formInputPadding,
    this.label,
    this.error,
    this.value,
    this.leading,
    this.icon,
    this.hint = "",
    this.minLines = 1,
    this.maxLines = 1,
    this.borderWidth = 0,
    this.borderColor = grey200,
    this.bgColor = grey200,
    this.labelColor = grey200,
    this.textColor = black,
    this.hintColor,
    this.textAlign = TextAlign.start,
    this.fontSize = 14,
    this.type,
    this.readOnly = false,
    this.maxLength,
    this.money = false,
    this.focusNode,
    this.autoFocus,
    this.iconSize = 20,
    this.obscureText = false,
    this.onClear,
    this.onChange,
    this.onClick,
  }) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final TextEditingController inputController = TextEditingController();
  bool overrideObscureText = false;

  List<TextInputFormatter> _getFormatters() {
    if (widget.money) {
      return [ThousandsSeparatorInputFormatter()];
    } else if (widget.type == TextInputType.phone)
      return [FilteringTextInputFormatter.allow(RegExp("[0-9]"))];
    else
      return [];
  }

  Widget _buildInput() {
    var bgColor = colorScheme(context).onSurface.withOpacity(0.03);
    var borderColor = colorScheme(context).outlineVariant;
    var labelColor = widget.error != null
        ? colorScheme(context).error
        : colorScheme(context).onSurface;
    var hintColor = colorScheme(context).onSurface.withOpacity(0.4);

    var input = Stack(
      children: [
        TextField(
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLength == null
              ? MaxLengthEnforcement.none
              : _getFormatters().length == 0
                  ? MaxLengthEnforcement.enforced
                  : MaxLengthEnforcement.truncateAfterCompositionEnds,
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus ?? false,
          obscureText: overrideObscureText ? false : widget.obscureText,
          textAlign: widget.textAlign,
          readOnly: widget.readOnly || widget.onClick != null,
          keyboardType: widget.type,
          controller: inputController,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          buildCounter: (
            _, {
            required currentLength,
            maxLength,
            required isFocused,
          }) =>
              null,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: hintColor),
            // counterStyle: TextStyle(
            //   height: double.minPositive,
            // ),
            // counterText: "",
            filled: true,
            fillColor: bgColor,
            isDense: true,
            contentPadding: widget.padding,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: widget.borderWidth,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(
                widget.minLines > 1 ? 15 : 50,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: widget.borderWidth,
                color: borderColor,
              ),
              borderRadius:
                  BorderRadius.circular(widget.minLines > 1 ? 15 : 50),
            ),
          ),
          style: TextStyle(fontSize: widget.fontSize, color: labelColor),
          onChanged: (newValue) {
            if (widget.onChange == null) return;

            widget.onChange!(
              !widget.money ? newValue : newValue.replaceAll(",", ""),
            );
          },
          inputFormatters: _getFormatters(),
        ),
        if (widget.onClear != null || widget.obscureText)
          Positioned(
            right: 4,
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.65,
              child: Row(
                children: [
                  if (widget.obscureText)
                    IconButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                        ),
                      ),
                      icon: Icon(
                        overrideObscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          overrideObscureText = !overrideObscureText;
                        });
                      },
                    ),
                  if (widget.onClear != null &&
                      widget.value != null &&
                      widget.value!.isNotEmpty)
                    IconButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.close, size: 18),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        inputController.text = "";
                        widget.onClear!();
                      },
                    ),
                ],
              ),
            ),
          ),
      ],
    );

    if (widget.onClick != null) {
      double leadingWidth = 46;
      double leadingHeight = 40;

      return Stack(
        children: [
          GestureDetector(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(
                left: widget.leading != null ? 0 : 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: widget.borderWidth,
                  color: borderColor,
                ),
              ),
              child: Row(
                children: <Widget>[
                  if (widget.leading != null)
                    Container(
                      width: leadingWidth,
                      margin: const EdgeInsets.only(right: 6),
                    ),
                  Expanded(
                    child: Opacity(
                      opacity: widget.value != null ? 1 : 0.7,
                      child: Text(
                        widget.value != null ? widget.value! : widget.hint,
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.value != null
                              ? colorScheme(context).onSurface
                              : hintColor,
                        ),
                      ),
                    ),
                  ),
                  if (widget.icon != null)
                    Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: hintColor,
                    ),
                ],
              ),
            ),
            onTap: () {
              widget.onClick!();
            },
          ),
          if (widget.leading != null)
            Positioned(
              top: 0,
              left: 0,
              width: leadingWidth,
              height: leadingHeight,
              child: Container(
                width: leadingWidth,
                height: leadingHeight,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 0.3,
                      color: borderColor,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  child: widget.leading!,
                ),
              ),
            ),
        ],
      );
    }

    return input;
  }

  @override
  void initState() {
    super.initState();
    if (widget.value != null) inputController.text = widget.value!;
  }

  @override
  Widget build(BuildContext context) {
    var textColor = widget.error != null
        ? colorScheme(context).error
        : colorScheme(context).onSurface;

    if (widget.value != null && widget.onChange == null) {
      inputController.text = widget.value!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 3),
            child: Text(
              widget.label!,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                // letterSpacing: 0.5,
              ),
            ),
          ),
        _buildInput(),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 3),
            child: Text(
              widget.error!,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                // letterSpacing: 0.5,
              ),
            ),
          ),
        const SizedBox(height: 6),
      ],
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
