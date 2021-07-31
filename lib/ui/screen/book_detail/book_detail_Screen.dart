/*
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/BookDetail.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart'
    as _CDRS;
import 'package:masterstudy_app/data/repository/auth_repository.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/book_detail/bloc.dart';
import 'package:masterstudy_app/ui/bloc/books/bloc.dart';

import 'package:masterstudy_app/ui/bloc/course/bloc.dart';
import 'package:masterstudy_app/ui/screen/book_search_detail/book_search_detail_screen.dart';
import 'package:masterstudy_app/ui/widgets/MeasureSizeWidget.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:io';
import '../../../main.dart';
import '../../bloc/book_detail/bloc.dart';

class BookDetailArgs {
  num id;
  String title;
  String subtitle;

ImagesBean images;
  List<String> categories;
  PriceBean price;
  RatingBean rating;
  String featured;
  StatusBean status;
  List<Category> categories_object;


  BookDetailArgs.fromCourseBean(BookBean bookBean)
      : id = bookBean.id,
        subtitle = bookBean.subtitle,
        title = bookBean.title;

BookDetailArgs.fromOrderListBean(Cart_itemsBean cart_itemsBean)
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

class BookDetail extends StatelessWidget {
  static const routeName = "bookDetail";
  final BookDetailBlock _bloc;

  const BookDetail(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    final BookDetailArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<BookDetailBlock>(
        create: (c) => _bloc, child: _BookDetailWidget(args));
  }
}

class _BookDetailWidget extends StatefulWidget {
  final BookDetailArgs bookBean;

  const _BookDetailWidget(this.bookBean);

  @override
  State<StatefulWidget> createState() {
    return _BookDetailWidgetState();
  }
}

class _BookDetailWidgetState extends State<_BookDetailWidget> {
  BookDetailBlock _bloc;
  BookDetails response;
  String isBookmark;
  String bookmarkIcon;
  TextEditingController _notes = TextEditingController();
  WebViewController _descriptionWebViewController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BookDetailBlock>(context)
      ..add(FetchBookDetailEvent(widget.bookBean.id));
  }

  @override
  void dispose() {
    super.dispose();
    _BookDetailWidgetState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();

    return BlocListener<BookDetailBlock, BookDetailState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is LoadedBookDetailState) {
          setState(() {
            isBookmark = state.bookDetail.isBookmark;
            bookmarkIcon = state.bookDetail.isBookmark != null
                ? 'assets/icons/book-bookmark-fill-icon.png'
                : 'assets/icons/book-bookmark-icon.png';
          });
        }
      },
      child: BlocBuilder<BookDetailBlock, BookDetailState>(
          builder: (context, state) {
        if (state is InitialBookDetailState) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is LoadedBookDetailState) {
          response = state.bookDetail;
        }
        return Scaffold(
          key: _key,
          backgroundColor: HexColor.fromHex("#F3F5F9"),
          drawer: DrawerScreen(),
          appBar: AppBar(
              leading: IconButton(
                icon: Image.asset(
                  'assets/icons/drawer-icon.png',
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  _descriptionWebViewController.clearCache();
                  _key.currentState.openDrawer();
                },
              ),
              actions: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          BookSearchDetailScreen.routeName,
                          arguments: BookSearchDetailScreenArgs(""));
                    },
                  ),
                  padding: EdgeInsets.only(right: 14),
                )
              ],
              backgroundColor: HexColor.fromHex('#2f3c6e'),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight - 18),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.only(right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 30,
                              width: 30,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/icons/back-icon.png',
                                  fit: BoxFit.contain,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                          Flexible(
                            child: Container(
                              child: Text(
                                response.title,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
          body: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: _buildDescription(state)),
        );
      }),
    );
  }

  //double descriptionHeight;

  _buildDescription(state) {
    if (state is InitialCourseState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 14),
              child: GestureDetector(
                child: Image.asset(
                  bookmarkIcon,
                  height: 45,
                  width: 45,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  setState(() {
                    isBookmark = isBookmark != null ? null : "1";
                    bookmarkIcon = isBookmark != null
                        ? 'assets/icons/book-bookmark-fill-icon.png'
                        : 'assets/icons/book-bookmark-icon.png';
                  });
                  if (state is LoadedBookDetailState) {
                    if (state.bookDetail.isBookmark != null) {
                      _bloc.add(
                          DeleteBookFromFavouriteEvent(response.id));
                    } else {
                      _bloc
                          .add(AddBookToFavouriteEvent(response.id));
                    }
                  }
                },
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        response.title,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: HexColor.fromHex('#2f3c6e'),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        response.subtitle,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.star,
                              size: 26,
                              color: mainColor,
                            ),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      RatingDialog(response.id, _bloc));
                            },
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            minWidth: 20,
                            height: 30,
                            child: Text('طلب نسخة ورقية'),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      BookRequestDialog(_bloc, response.id));
                            },
                            color: mainColor,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(this.response.description))}',
            onWebViewCreated: (controller) async {
              controller.clearCache();
              this._descriptionWebViewController = controller;
            },
          ),
        ),
      ),
    ]);
  }
}

class BookRequestDialog extends StatelessWidget {
  BookDetailBlock _bloc;
  int id;

  BookRequestDialog(this._bloc, this.id);

  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailBlock, BookDetailState>(
        bloc: _bloc,
        builder: (context, state) {
          return Container(
            child: Stack(
              children: <Widget>[
                Dialog(
                  child: Container(
                    height: 300,
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 230,
                          width: 340,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: TextFormField(
                            controller: _notes,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            maxLines: 20,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'اكتب ملاحظة',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 30,
                                  width: 80,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      'أغلق',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: mainColor,
                                    textColor: Colors.white,
                                  )),
                              Container(
                                  width: 160,
                                  height: 30,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      'تقديم الطلب',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    onPressed: () async {
                                      _bloc.add(RequestForBookEvent(
                                          id, _notes.text));
                                      Navigator.pop(context);
                                      await showDialog(
                                          context: context,
                                          builder: (_) => SuccessDialog());
                                    },
                                    color: mainColor,
                                    textColor: Colors.white,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'قدمت',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 22),
          ),
          Container(
              height: 30,
              width: 100,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'حسنا',
                  textDirection: TextDirection.rtl,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: mainColor,
                textColor: Colors.white,
              ))
        ],
      ),
    ));
  }
}

class RatingDialog extends StatefulWidget {
  int id;
  BookDetailBlock _bloc;

  RatingDialog(this.id, this._bloc);

  @override
  State<StatefulWidget> createState() {
    return RatingDialogState();
  }
}

class RatingDialogState extends State<RatingDialog> {
  double _rating = 0.0;
  bool isRatingSubmited = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: RatingBar(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              tapOnlyMode: true,
              glow: false,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: mainColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
          ),
 Visibility(
            visible: isRatingSubmited,
            child: Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'تم إرسال التقييم',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: HexColor.fromHex('#2f3c6e'),
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                )),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 30,
                    width: 100,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'إلغاء',
                        textDirection: TextDirection.rtl,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: mainColor,
                      textColor: Colors.white,
                    )),
                Container(
                    height: 30,
                    width: 100,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'إرسال',
                        textDirection: TextDirection.rtl,
                      ),
                      onPressed: () async {
                        widget._bloc.add(
                            BookRatingEvent(widget.id, _rating));
                        Navigator.pop(context);
                        await showDialog(
                            context: context, builder: (_) => SuccessDialog());
 setState(() {
                          isRatingSubmited = true;
                        });

                      },
                      color: mainColor,
                      textColor: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
*/
