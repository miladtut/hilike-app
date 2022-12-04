import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Utils/constants.dart';

class GiftScroll extends StatelessWidget {
  final List<GiftModel> gifts;

  const GiftScroll({Key? key, required this.gifts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Container(
        height: 56.13,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: gifts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            GiftModel item = gifts[index];
            return Row(
              children: [
                Container(
                  width: 55.13,
                  height: 56.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 0.50,
                    ),
                    color: Color(0xff212121),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CachedNetworkImage(
                      imageUrl: item.image ?? imgPlaceholder,
                    ),
                  ),
                ),
                if (gifts.indexOf(item) != gifts.length - 1)
                  SizedBox(
                    width: 5,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
