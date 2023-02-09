import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final title;
  final onPressed;

  RectangularButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size
    var size = MediaQuery.of(context).size;
    bool tablet = size.height > 926 && size.width > 428;
    return Material(
      borderRadius: BorderRadius.circular(7),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: !tablet ? 40 : 60,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: !tablet ? 16 : 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
