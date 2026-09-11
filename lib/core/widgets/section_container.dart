import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// Standard horizontal-padding + max-width wrapper used by every section
/// so the whole page keeps a consistent content column.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.verticalPadding,
    this.color,
  });

  final Widget child;
  final double? verticalPadding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final vPad = verticalPadding ?? Responsive.value<double>(context, mobile: 48, tablet: 64, desktop: 88);
    final hPad = Responsive.pageHorizontalPadding(context);
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.only(left: hPad.left, right: hPad.right, top: vPad, bottom: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.contentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}
