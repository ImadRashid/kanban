import 'package:flutter/material.dart';

typedef OnFooterAddButtonClick = void Function();

class BoardFooter extends StatefulWidget {
  final double height;
  final Widget? icon;
  final Widget? title;
  final EdgeInsets margin;
  final OnFooterAddButtonClick? onAddButtonClick;

  const BoardFooter({
    this.icon,
    this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    required this.height,
    this.onAddButtonClick,
    Key? key,
  }) : super(key: key);

  @override
  State<BoardFooter> createState() => _BoardFooterState();
}

class _BoardFooterState extends State<BoardFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: widget.onAddButtonClick,
          child: SizedBox(
            height: widget.height,
            child: Container(
              padding: widget.margin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.icon != null) widget.icon!,
                  const SizedBox(width: 8),
                  if (widget.title != null) widget.title!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
