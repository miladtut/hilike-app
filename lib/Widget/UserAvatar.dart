import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  final String image;
  final String? plan;
  final double size;
  final Function? onClick;

  const UserAvatar({
    Key? key,
    required this.image,
    this.plan,
    required this.size,
    this.onClick,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) widget.onClick!();
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.plan == null
                ? Colors.transparent
                : widget.plan == "Vip"
                    ? Color(0xffe5003a)
                    : widget.plan == "Gold"
                        ? Color(0xffffb84f)
                        : Colors.transparent,
            width: (widget.plan == "Gold" || widget.plan == "Vip") ? 1 : 0,
          ),
          color: Color(0xffc4c4c4),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.image,
          imageBuilder: (context, imageProvider) => Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
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
                  width: widget.size / 3,
                  height: widget.size / 3,
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
    );
  }
}
