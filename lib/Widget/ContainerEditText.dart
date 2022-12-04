import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class ContainerEditText extends StatefulWidget {
  final String title, text;
  final int maxCount;
  final Function(String? val) onChange;

  const ContainerEditText({
    Key? key,
    required this.title,
    required this.text,
    this.maxCount = 150,
    required this.onChange,
  }) : super(key: key);

  @override
  _ContainerEditTextState createState() => _ContainerEditTextState();
}

class _ContainerEditTextState extends State<ContainerEditText> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Container(
        width: size.width / 1.06,
        height: size.height / 5.5,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff292929),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 0.90,
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: size.width / 1.06 - 36,
              child: TextFormField(
                cursorColor: Color(0xffe5003a),
                textInputAction: TextInputAction.done,
                initialValue: widget.text,
                onChanged: (value) {
                  widget.onChange(value);
                },
                maxLength: widget.maxCount,
                maxLines: 3,
                style: TextStyle(
                  color: Color(0xffc4c4c4),
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).typeHere,
                  hintStyle: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 13,
                  ),
                  counterStyle: TextStyle(
                    color: Color(0xff505050),
                    fontSize: 10,
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
