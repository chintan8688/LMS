import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/widgets/book_grid_item.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';
import '../../bloc/book_bookmark/bloc.dart';

class BooksBookmark extends StatelessWidget {
  static const routeName = 'booksBookmarkScreen';

  final BookBookmarkBloc _bloc;

  BooksBookmark(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookBookmarkBloc>(
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
  BookBookmarkBloc _bloc;
  var unescape = new HtmlUnescape();
  String title;
  int selectedId = -99;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<BookBookmarkBloc>(context)
      ..add(FetchBookmarkEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return BlocBuilder<BookBookmarkBloc, BookBookmarkState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            key: _key,
            backgroundColor: HexColor.fromHex("#F3F5F9"),
            drawer: DrawerScreen(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: new AppBar(
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
                brightness: Brightness.dark,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Image.asset(
                    'assets/icons/appbarIcon.png',
                    fit: BoxFit.contain,
                    height: 80,
                  ),
                ),
                elevation: 0,
                backgroundColor: HexColor.fromHex('#2f3c6e'),
              ),
            ),
            /*AppBar(
                centerTitle: true,
                backgroundColor: HexColor.fromHex('#2f3c6e'),
                //actions: <Widget>[_buildTitleDropDown(state)],
                title: Image.asset(
                  'assets/icons/appbarIcon.png',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(kToolbarHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 18.0, left: 0, right: 2),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            BookSearchDetailScreen.routeName,
                                            arguments:
                                                BookSearchDetailScreenArgs(""));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 8),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                180,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                elevation: 4,
                                                color: Colors.white,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                      child: Text(
                                                                          localizations.getLocalization(
                                                                              "books_search_bar_title"),
                                                                          textDirection: TextDirection
                                                                              .rtl,
                                                                          textScaleFactor:
                                                                              1.0,
                                                                          style: TextStyle(
                                                                              color: Colors.black.withOpacity(0.5),
                                                                              height: 2,
                                                                              fontSize: 14))),
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
                            ],
                          ))
              ),*/
            body: _buildBody(state),
          );
        });
  }

  _buildBody(BookBookmarkState state) {
    if (state is ErrorBookmarkBookState)
      return Center(
        child: LoadingErrorWidget(() {
          _bloc.add(FetchBookmarkEvent());
        }),
      );

    if (state is InitialBookmarkBookState) return _buildLoading();

    if (state is LoadedBookmarkBookState) {
      if (state.books == null || state.books.isEmpty) {
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'لا يوجد سجل',
                textScaleFactor: 1.0,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: HexColor.fromHex('#2f3c6e')),
              ),
            ],
          ),
        ));
      }

      return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              /*Padding(
                padding:
                const EdgeInsets.only(top: 20.0, right: 18.0, bottom: 5.0),
                child: Text(unescape.convert(title),
                    textScaleFactor: 1.0,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(color: dark, fontStyle: FontStyle.normal))),*/
              Container(
                margin: EdgeInsets.only(top: 10),
                child: _buildBooks(state),
              )
            ]),
      );
    }
  }

  _buildBooks(LoadedBookmarkBookState state) {
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

  /*_buildTitleDropDown(BookState state) {
    if (state is InitialBookState) return Center();
    if (state is LoadedBookState) {
      var course = state.category.where((element) => element.id == selectedId);

      for (var i in course) {
        title = i.name.toString();
      }
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
  }*/

  _buildLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
