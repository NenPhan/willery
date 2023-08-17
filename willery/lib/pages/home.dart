import 'package:flutter/material.dart';
import 'package:willery/widgets/color_picker.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: ColorPickerPanel(
          onTap: () {},
          color: Colors.black,
        ),
      ),
    );
  }
}
