import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:masterstudy_app/data/models/OrdersResponse.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart'
    as _CDR;
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/course/bloc.dart';
import 'package:masterstudy_app/ui/widgets/MeasureSizeWidget.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:io';
import '../../../main.dart';

class BookSectionArgs {
  num id;
  String title;
  ImagesBean images;
  List<String> categories;
  PriceBean price;
  RatingBean rating;
  String featured;
  StatusBean status;
  List<Category> categories_object;

  BookSectionArgs.fromCourseBean(CoursesBean coursesBean)
      : id = coursesBean.id,
        title = coursesBean.title,
        images = coursesBean.images,
        categories = coursesBean.categories,
        price = coursesBean.price,
        rating = coursesBean.rating,
        featured = coursesBean.featured,
        status = coursesBean.status,
        categories_object = coursesBean.categories_object;

  BookSectionArgs.fromOrderListBean(Cart_itemsBean cart_itemsBean)
      : id = cart_itemsBean.cart_item_id,
        title = cart_itemsBean.title,
        images = ImagesBean(
            full: cart_itemsBean.image_url, small: cart_itemsBean.image_url),
        categories = null,
        price = null,
        rating = null,
        featured = null,
        status = null,
        categories_object = null;
}

class BookSection extends StatelessWidget {
  static const routeName = "bookSection";
  final CourseBloc _bloc;

  const BookSection(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    final BookSectionArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<CourseBloc>(
        create: (c) => _bloc, child: _BookSectionWidget(args));
  }
}

class _BookSectionWidget extends StatefulWidget {
  final BookSectionArgs coursesBean;

  const _BookSectionWidget(this.coursesBean);

  @override
  State<StatefulWidget> createState() {
    return _BookSectionWidgetState();
  }
}

class _BookSectionWidgetState extends State<_BookSectionWidget> {
  CourseBloc _bloc;
  _CDR.CourseDetailResponse response;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CourseBloc>(context)
      ..add(FetchEvent(widget.coursesBean.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadedCourseState) {
            response = state.courseDetailResponse;
          }
          return Scaffold(
            backgroundColor: HexColor.fromHex("#F3F5F9"),
            drawer: DrawerScreen(),
            appBar: AppBar(
                actions: <Widget>[
                  Container(
                    child: Icon(Icons.search),
                    padding: EdgeInsets.only(right: 14),
                  )
                ],
                backgroundColor: HexColor.fromHex('#2f3c6e'),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight + 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(bottom: 5, right: 14),
                                  child: Text("Section One",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 5, right: 14),
                            child: Text(
                              'Subtitle Of Section',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ))),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: _buildDescription(state),
            ),
          );
        });
  }

  void auth() {}

  WebViewController _descriptionWebViewController;
  double descriptionHeight;

  _buildDescription(state) {
    if (state is InitialCourseState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (Platform.isAndroid && (androidInfo.version.sdkInt == 28))
      return _buildHtmlDesctription();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 224,
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(this.response.description))}',
              onPageFinished: (some) async {
                double height = double.parse(
                    await _descriptionWebViewController.evaluateJavascript(
                        "document.documentElement.scrollHeight;"));
                setState(() {
                  descriptionHeight = height;
                });
              },
              onWebViewCreated: (controller) async {
                controller.clearCache();
                this._descriptionWebViewController = controller;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 150,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              minWidth: double.infinity,
              color: mainColor,
              child: Text(
                "Start The Job",
                textScaleFactor: 1.0,
              ),
              onPressed: auth,
              textColor: Colors.white,
            ),
          )
        ]);
  }

  var htmlDesctriptionHeight = 300.0;

  _buildHtmlDesctription() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.clip,
                children: [
                  Positioned(
                      top: -130.0,
                      child: MeasureSize(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 34,
                            child: Html(
                              data: this.response.description,
                              useRichText: true,
                              shrinkToFit: false,
                            )),
                        onChange: (size) {
                          setState(() {
                            htmlDesctriptionHeight = size.height - 130;
                          });
                        },
                      ))
                ])),
      ])
    ]);
  }
}
