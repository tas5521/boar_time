import 'package:flutter/material.dart';

Widget iconActionButton(
  BuildContext context, {
  required Future<void> Function() onPressed,
  required Icon icon,
  bool enabled = true,
}) {
  return IconButton(
    onPressed: enabled ? () => onPressed() : null,
    icon: icon,
  );
}
