// import 'package:flutter/material.dart';

// class BottomNavigationBarCustom extends StatelessWidget {
//   const BottomNavigationBarCustom({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(double.infinity, 100),
//       painter: BottomNavigationBarPainter(context: context),
//     );
//   }
// }

// class BottomNavigationBarPainter extends CustomPainter {
//   const BottomNavigationBarPainter({
//     required this.context,
//   });

//   final BuildContext context;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint();
//     paint.color = Theme.of(context).primaryColor;
//     paint.style = PaintingStyle.fill;

//     final Path path = Path();

//     final width = size.width;
//     final height = size.height;
//     path.moveTo(0.0, height * 0.10);
//     path.lineTo((width / 2) - 30.0, height * 0.10);
//     path.quadraticBezierTo(x1, y1, x2, y2)
//     path.lineTo((width / 2) + 30.0, height * 0.10);
//     path.lineTo(
//       width,
//       height * 0.10,
//     );
//     path.lineTo(width, height);
//     path.lineTo(0.0, height);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(BottomNavigationBarPainter oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(BottomNavigationBarPainter oldDelegate) => false;
// }
