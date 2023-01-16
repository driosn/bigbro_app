import 'package:flutter/material.dart';

class VerticalSpacing {
  static Widget xs = const SizedBox(
    height: SpacingValues.xs,
  );

  static Widget s = const SizedBox(
    height: SpacingValues.s,
  );

  static Widget m = const SizedBox(
    height: SpacingValues.m,
  );

  static Widget l = const SizedBox(
    height: SpacingValues.l,
  );

  static Widget xl = const SizedBox(
    height: SpacingValues.xl,
  );
}

class HorizontalSpacing {
  static Widget xs = const SizedBox(
    width: SpacingValues.xs,
  );

  static Widget s = const SizedBox(
    width: SpacingValues.s,
  );

  static Widget m = const SizedBox(
    width: SpacingValues.m,
  );

  static Widget l = const SizedBox(
    width: SpacingValues.l,
  );

  static Widget xl = const SizedBox(
    width: SpacingValues.xl,
  );
}

class SpacingValues {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 20.0;
}
