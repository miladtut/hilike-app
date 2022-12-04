import 'package:flutter/material.dart';
import 'package:hilike/Models/id_name.dart';
import 'package:hilike/generated/l10n.dart';

class FilterRow extends StatefulWidget {
  final String text;
  final String? text2;
  final Function onTap;
  final bool? isList;
  final List? langList;

  const FilterRow(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isList,
      this.text2,
      this.langList})
      : super(key: key);

  @override
  _FilterRowState createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  @override
  Widget build(BuildContext context) {
    return widget.isList ?? false
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffc4c4c4),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Container(
                    width: 130,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xfff5f5f5),
                        width: 1,
                      ),
                    ),
                    child: widget.langList!.length > 1
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < widget.langList!.length;
                                    i++)
                                  Text(
                                    (widget.langList![i] as IdNameModel).name! +
                                        " , ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xfff5f5f5),
                                      fontSize: 13,
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              (widget.langList![0] as IdNameModel).name!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xfff5f5f5),
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffc4c4c4),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Container(
                    width: 130,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xfff5f5f5),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.text2 ?? S.of(context).notSpecify,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xfff5f5f5),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
