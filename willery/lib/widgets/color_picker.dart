// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:willery/app/app_config.dart';

class ColorPickerPanel extends StatefulWidget {
  const ColorPickerPanel({
    Key? key,
    this.color,
    this.items,
    this.onChangeColor,
    this.onTap,
    this.panelWidth = 200,
    this.panelHeight = 160,
    this.buttonHeight = 25,
    this.itemButtonHeight = 30,
  }) : super(key: key);
  final Function(Color)? onChangeColor;
  final Color? color;
  final List<Color>? items;
  final VoidCallback? onTap;
  final double panelWidth;
  final double panelHeight;
  final double buttonHeight;
  final double itemButtonHeight;
  @override
  State<ColorPickerPanel> createState() => _ColorPickerPanelState();
}

class _ColorPickerPanelState extends State<ColorPickerPanel> {
  final LayerLink layerLink = LayerLink();
  var colors = [
    4293344059,
    4294939904,
    4281257095,
    4278221567,
    4294139788,
    4294819885,
    4282237640,
    4289680094,
    4294606711,
    4287922296,
    4282888951,
    4289956827
  ];
  int selectedColor = 4293344059;

  @override
  void initState() {
    if (widget.items != null) {
      colors = widget.items!.map((e) => colorToInt(e)).toList();
    }
    if (widget.color != null) {
      selectedColor = colorToInt(widget.color!);
    }
    super.initState();
  }

  int colorToInt(Color color) {
    return int.parse('0x${color.value.toRadixString(16)}');
  }

  void togglePanel(BuildContext context, TapDownDetails details) {
    var bottom = WidgetsBinding.instance.window.viewInsets.bottom;
    if (AppConfig.instance(context)!.overlayEntry.mounted) {
      hidePanel(context);
    } else {
      AppConfig.instance(context)!.overlayEntry = OverlayEntry(builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Positioned(
          top: 0,
          left: 0,
          child: CompositedTransformFollower(
            link: layerLink,
            offset: Offset(
                -widget.panelWidth + widget.buttonHeight,
                bottom > 0 && bottom - details.globalPosition.dy < widget.panelHeight + 10 ||
                        size.height - details.globalPosition.dy < widget.panelHeight + 10
                    ? -widget.panelHeight - 2
                    : widget.buttonHeight + 2),
            child: SizedBox(
              width: widget.panelWidth,
              height: widget.panelHeight,
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5), border: Border.all(color: Colors.grey, width: .2)),
                      child: Wrap(
                        spacing: 5,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: List.generate(
                          colors.length,
                          (index) => _buildColorSelectionItem(colors[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
      Overlay.of(context).insert(AppConfig.instance(context)!.overlayEntry);
    }
  }

  _buildColorSelectionItem(int newColor) {
    return SizedBox(
      height: widget.itemButtonHeight,
      width: widget.itemButtonHeight,
      child: GestureDetector(
        onTap: () {
          selectedColor = newColor;
          setState(() {});
          hidePanel(context);
          if (widget.onChangeColor != null) {
            widget.onChangeColor!(Color(newColor));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(newColor),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.all(2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        if (widget.onTap != null) {
          togglePanel(context, details);
          widget.onTap!();
        }
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: Container(
          width: widget.buttonHeight,
          height: widget.buttonHeight,
          decoration: BoxDecoration(
              color: Color(selectedColor),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: Colors.grey)),
        ),
      ),
    );
  }
}
