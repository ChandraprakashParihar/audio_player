import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get sBH => SizedBox(height: toDouble());
  SizedBox get sBW => SizedBox(width: toDouble());
}
