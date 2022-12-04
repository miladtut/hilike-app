import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Utils/constants.dart';

class OthersPhotosCard extends StatefulWidget {
  final UserMobx userMobx;
  final int index;
  final Function(int index)? onClick;

  const OthersPhotosCard({Key? key, required this.userMobx, required this.index, this.onClick}) : super(key: key);

  @override
  _OthersPhotosCardState createState() => _OthersPhotosCardState();
}

class _OthersPhotosCardState extends State<OthersPhotosCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.onClick != null) widget.onClick!(widget.index);
      },
      child: Container(
        width: 130,
        height: 210,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: CachedNetworkImage(
            imageUrl:
            widget.userMobx.user!
                    .images![widget.index].image ??
                imgPlaceholder,
            imageBuilder: (context, imageProvider) => Container(
              width: 130,
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
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
      ),
    );
  }
}
