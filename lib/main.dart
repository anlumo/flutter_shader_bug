import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shader Demo',
      home: ShaderDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShaderDemo extends StatefulWidget {
  const ShaderDemo({super.key});

  @override
  State<ShaderDemo> createState() => _ShaderDemoState();
}

class _ShaderDemoState extends State<ShaderDemo> {
  FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    FragmentProgram.fromAsset('shaders/demo.frag').then((program) {
      setState(() {
        _shader = program.fragmentShader();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_shader != null) {
      return CustomPaint(
        painter: _FragmentShaderPainter(shader: _shader!),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class _FragmentShaderPainter extends CustomPainter {
  _FragmentShaderPainter({required this.shader});

  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height);

    canvas.drawRect(rect, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
