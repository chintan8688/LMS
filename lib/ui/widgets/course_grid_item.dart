import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/course/course_screen.dart';

import '../../main.dart';

class CourseGridItem extends StatelessWidget {
  final CoursesBean coursesBean;

  CourseGridItem(this.coursesBean);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          CourseScreen.routeName,
          arguments: CourseScreenArgs.fromCourseBean(coursesBean),
        );
      },
      child: _buildCard(context),
    );
  }

  _buildCard(context) {
    var rating = 0.0;
    var reviews = 0;
    if (coursesBean.rating.total != null) {
      rating = coursesBean.rating.average.toDouble();
    }
    if (coursesBean.rating.total != null) {
      reviews = coursesBean.rating.total;
    }

    var unescape = new HtmlUnescape();
    double imgHeight =
        (MediaQuery.of(context).size.width > 450) ? 220.0 : 180.0;
    String categoryName = (coursesBean.categories_object != null)
        ? coursesBean.categories_object.first.name
        : ""; 
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Hero(
                        tag: coursesBean.id,
                        child: Image.network(
                          coursesBean.images.small ?? "",
                          width: double.infinity,
                          height: imgHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: GestureDetector(
                            /*onTap: () {
                              Navigator.pushNamed(
                                context,
                                CategoryDetailScreen.routeName,
                                arguments: CategoryDetailScreenArgs(
                                    coursesBean.categories_object.first),
                              );
                            },*/
                            child: Text(
                          unescape.convert(categoryName),
                          textDirection: TextDirection.rtl,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(unescape.convert(coursesBean.title),
                            textDirection: TextDirection.rtl,
                            textScaleFactor: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle
                                .copyWith(
                                  color: Colors.black,
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            RatingBar(
                              initialRating: rating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              tapOnlyMode: true,
                              glow: false,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 14,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: mainColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              "($reviews) $rating ",
                              textDirection: TextDirection.rtl,
                              textScaleFactor: 1.0,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .caption
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      /* Container(
                  alignment: Alignment.center,
                  child: _buildPrice(context),
                ) */
                    ],
                  ),
                )),
            /* Visibility(
                visible: coursesBean.featured == "on" ? true : false,
                child: Positioned(
                    top: 20.0,
                    right: 0.0,
                    child: Container(
                        decoration:
                            BoxDecoration(color: HexColor.fromHex('#ee633c')),
                        width: 80.0,
                        height: 24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "الممتازة",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )))), */
          ],
        ));
  }

  /* _buildPrice(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 0.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            coursesBean.price.free
                ? localizations.getLocalization("free_course_item")
                : coursesBean.price.price,
            textScaleFactor: 1.0,
            style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: dark,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              (coursesBean.price.old_price != null)
                  ? coursesBean.price.old_price.toString()
                  : " ",
              textScaleFactor: 1.0,
              style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                  color: HexColor.fromHex("#999999"),
                  fontStyle: FontStyle.normal,
                  decoration: (coursesBean.price.old_price != null)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          )
        ],
      ),
    );
  } */

  /* _buildPrice(context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minWidth: 20,
      height: 30,
      child: Text('Donate'),
      onPressed: getBook,
      color: mainColor,
      textColor: Colors.white,
    );
  } */

  void getBook() {}
}
