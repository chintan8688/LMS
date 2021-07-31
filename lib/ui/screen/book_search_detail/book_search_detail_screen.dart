/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/book_search_detail/bloc.dart';
import 'package:masterstudy_app/ui/widgets/book_grid_item.dart';

class BookSearchDetailScreenArgs {
  final String searchText;

  BookSearchDetailScreenArgs(this.searchText);
}

class BookSearchDetailScreen extends StatelessWidget {
  static const routeName = "bookSearchDetailScreen";
  final BookSearchDetailBloc _bloc;

  const BookSearchDetailScreen(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    BookSearchDetailScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<BookSearchDetailBloc>(
      child: SearchDetailWidget(args.searchText),
      create: (_) => _bloc,
    );
  }
}

class SearchDetailWidget extends StatefulWidget {
  final String searchText;

  const SearchDetailWidget(this.searchText) : super();

  @override
  State<StatefulWidget> createState() {
    return _SearchDetailWidgetState();
  }
}

class _SearchDetailWidgetState extends State<SearchDetailWidget> {
  BookSearchDetailBloc _bloc;
  final TextEditingController _searchQuery = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.searchText != "") {
      this._searchQuery.text = widget.searchText;
    }

    _bloc = BlocProvider.of<BookSearchDetailBloc>(context)
      ..add(FetchEvent(this._searchQuery.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F3F5F9"),
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          style: TextStyle(fontSize: 20),
          controller: _searchQuery,
          onChanged: (value) {
            if (value.trim().length > 1) _bloc.add(FetchEvent(value));
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: localizations.getLocalization("books_search_bar_title"),
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
      body: BlocBuilder<BookSearchDetailBloc, BookSearchDetailState>(
        bloc: _bloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is LoadingSearchDetailState) return _buildLoadingWidget();

          if (state is LoadedSearchDetailState) {
            if (state.books.isEmpty) {
              return _buildEmptyResults();
            } else {
              return _buildBooks(state.books);
            }
          }
          return Center();
        },
      ),
    );
  }

  _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildBooks(List<BookBean> books) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
      child: Container(
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 4,
          staggeredTileBuilder: (_) => StaggeredTile.fit(2),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          itemCount: books.length,
          itemBuilder: (context, index) {
            var item = books[index];
            var paddingBottom = 0.0;
            if (index == books.length - 1) paddingBottom = 16.0;
            return Padding(
              padding: EdgeInsets.only(bottom: paddingBottom),
              child: BookGridItem(item),
            );
          },
        ),
      ),
    );
  }

  _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 150,
            color: Colors.grey[400],
          ),
          Text(
            localizations.getLocalization("nothing_found_search"),
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.grey[500], fontSize: 22),
          ),
          Text(
            "${_searchQuery.text}",
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.grey[500], fontSize: 18),
          ),
        ],
      ),
    );
  }
}
*/
