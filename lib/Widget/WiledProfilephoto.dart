import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class Profilephoto extends StatefulWidget {
  final String img;
  final num count, index;
  final bool? noPhoto;

  const Profilephoto({
    Key? key,
    required this.img,
    this.noPhoto,
    required this.count,
    required this.index,
  }) : super(key: key);

  @override
  _ProfilephotoState createState() => _ProfilephotoState();
}

class _ProfilephotoState extends State<Profilephoto> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(alignment: AlignmentDirectional.center, children: [
      Container(
        width: size.width / 1,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                alignment: Alignment.topCenter,
                imageUrl: widget.img,
                imageBuilder: (context, imageProvider) => Container(
                  margin: widget.noPhoto ?? false
                      ? EdgeInsets.fromLTRB(0, 0, 0, size.height / 15)
                      : EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: size.width / 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: widget.noPhoto ?? false
                            ? BoxFit.scaleDown
                            : BoxFit.cover,
                        scale:widget.noPhoto ?? false
                            ?2: 1.8),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width / 12,
                        height: size.width / 12,
                        child: CircularProgressIndicator(
                          color: Color(0xffe5003a),
                          strokeWidth: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      if (widget.count > 1)
        Positioned(
          bottom: size.height / 10.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.count; i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          i == widget.index ? Colors.white : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
    ]);
  }
}
