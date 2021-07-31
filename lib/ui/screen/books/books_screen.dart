import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:masterstudy_app/data/models/BookCategory.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/books/bloc.dart';
import 'package:masterstudy_app/ui/screen/book_search_detail/book_search_detail_screen.dart';
import 'package:masterstudy_app/ui/widgets/book_grid_item.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import '../../../main.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';
import '../../bloc/books/bloc.dart';

class BookScreen extends StatelessWidget {
  static const routeName = 'bookScreen';

  BookBlock _bloc;

  BookScreen(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookBlock>(
        create: (c) => _bloc, child: _BookScreenWidget());
  }
}

class _BookScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookScreenWidgetState();
  }
}

class _BookScreenWidgetState extends State<_BookScreenWidget> {
  BookBlock _bloc;
  var unescape = new HtmlUnescape();
  String title;
  int selectedId = -99;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<BookBlock>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return BlocBuilder<BookBlock, BookState>(
        bloc: _bloc,
        builder: (context, state) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                key: _key,
                backgroundColor: HexColor.fromHex("#F3F5F9"),
                drawer: DrawerScreen(),
                appBar: AppBar(
                  leading: Transform.scale(
                    scale: 0.7,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/drawer-icon.svg',
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        _key.currentState.openDrawer();
                      },
                    ),
                  ),
                  backgroundColor: HexColor.fromHex('#2f3c6e'),
                  actions: <Widget>[_buildTitleDropDown(state)],
                  /*bottom: PreferredSize(
                        preferredSize:
                            const Size.fromHeight(kToolbarHeight + 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 18.0, left: 0, right: 2),
                                child: InkWell(
                                    */ /*onTap: () {
                                      Navigator.of(context).pushNamed(
                                          BookSearchDetailScreen.routeName,
                                          arguments:
                                          BookSearchDetailScreenArgs(""));
                                    },*/ /*
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      width: MediaQuery.of(context).size.width -
                                          180,
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          elevation: 4,
                                          color: Colors.white,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(children: <Widget>[
                                                        Expanded(
                                                            child: Text(
                                                                localizations.getLocalization(
                                                                    "books_search_bar_title"),
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                textScaleFactor:
                                                                    1.0,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    height: 2,
                                                                    fontSize:
                                                                        14))),
                                                      ])
                                                    ],
                                                  )))),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
                                ))),
                            */ /*Container(
                              child: ColoredTabBar(
                                  Colors.white,
                                  TabBar(
                                    indicatorColor: mainColorA,
                                    tabs: [
                                      Tab(
                                        text: localizations.getLocalization(
                                            "course_overview_tab"),
                                      ),
                                      Tab(
                                          text: localizations.getLocalization(
                                              "course_curriculum_tab")),
                                    ],
                                  )),
                            )*/ /*
                          ],
                        ))*/
                ),
                body: _buildBody(state),
              ));
        });
  }

  _buildBody(BookState state) {
    if (state is ErrorBookState)
      return Center(
        child: LoadingErrorWidget(() {
          _bloc.add(FetchEvent());
        }),
      );
    if (state is InitialBookState) return _buildLoading();
    if (state is LoadedBookState) {
      if (state.books.isEmpty || state.books == null) {
        return Container(
          child: Center(
            child: Text(
              'لا يوجد كتاب',
              textScaleFactor: 1.0,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  color: HexColor.fromHex('#2f3c6e')),
            ),
          ),
        );
      }

      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: Text(
                      'كتـب',
                      style: TextStyle(
                          fontSize: 24,
                          color: HexColor.fromHex('#2f3c6e'),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Divider(
                      thickness: 3,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _buildBooks(state),
              ),
            )
          ]);
    }
  }

  _buildBooks(LoadedBookState state) {
    return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
            child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          staggeredTileBuilder: (_) => StaggeredTile.fit(2),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          itemCount: state.books.length,
          itemBuilder: (context, index) {
            var item = state.books[index];
            var paddingBottom = 0.0;
            if (index == state.books.length - 1) paddingBottom = 16.0;
            return Padding(
              padding: EdgeInsets.only(bottom: paddingBottom),
              child: BookGridItem(item),
            );
          },
        )));
  }

  _buildTitleDropDown(BookState state) {
    if (state is InitialBookState) return Center();
    if (state is LoadedBookState) {
      /*var course = state.category.where((element) => element.id == selectedId);

      for (var i in course) {
        title = i.name.toString();
      }*/
      title = state.category.first.name.toString();
      return Container(
        margin: EdgeInsets.only(right: 12),
        child: _buildDropDownCategory(state),
      );
    }
  }

  _buildDropDownCategory(LoadedBookState state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<BookCategory>(
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 28,
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          style: new TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          hint: Text(unescape.convert(title),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              textScaleFactor: 1.0,
              style: new TextStyle(color: Colors.white)),
          onChanged: (BookCategory selectedCat) {
            setState(() {
              //selCat = selectedCat;
              selectedId = selectedCat.id;
            });
            _bloc.add(FetchBookByIdEvent(selectedId));
          },
          items: state.category.map((BookCategory catList) {
            return new DropdownMenuItem<BookCategory>(
              value: catList,
              child: new Text(unescape.convert(catList.name),
                  textScaleFactor: 1.0,
                  style: new TextStyle(color: Colors.black)),
            );
          }).toList(),
        )),
      ),
    );
  }

  _buildLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
