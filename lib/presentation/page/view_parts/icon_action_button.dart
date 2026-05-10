import 'package:flutter/material.dart';

Widget iconActionButton(
  BuildContext context, {
  required Future<void> Function() onPressed,
  required Icon icon,
}) {
  return IconButton(onPressed: onPressed, icon: icon);
}
