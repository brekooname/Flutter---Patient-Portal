import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class DoctorListItem extends StatelessWidget {
  final String imageAsset;
  final String docName;
  final String type;
  final double rating;
  final int reviewCount;
  final double imageSize;
  final bool bigSize;
  final bool removeBottomMargin;
  DoctorListItem(
      this.imageAsset, this.docName, this.type, this.rating, this.reviewCount,
      [this.imageSize = 80,
      this.bigSize = false,
      this.removeBottomMargin = false]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 0,
      onTap: () {
        //context.navigateToScreen(BookAppointment());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: removeBottomMargin ? 0 : 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: new BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage(imageAsset),
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: bigSize ? 16 : 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: bigSize ? 20 : 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      type,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w300,
                          fontSize: bigSize ? 16 : 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Luxembourg Ville - 2 km",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w300,
                          fontSize: bigSize ? 16 : 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          itemCount: 5,
                          itemSize: bigSize ? 18 : 15.0,
                          unratedColor: Colors.black.withOpacity(0.2),
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "($reviewCount)",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: bigSize ? 16 : 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
