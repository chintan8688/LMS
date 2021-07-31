import 'dart:ui';

import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/BookCategory.dart';
import 'package:masterstudy_app/data/models/BookDetail.dart';

import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';

import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterstudy_app/data/utils.dart';

enum Sort { free, date_low, price_low, price_high, rating, popular, favorite }

abstract class BookRepository {
  Future<CourcesResponse> getBooks();

  Future<List<BookCategory>> getCategories();

  Future<CourcesResponse> getBooksById(int id);

  Future<BookDetails> getBook(int id);

  Future<CourcesResponse> getBookmark();

  Future requestForBook(int id, String notes);

  Future<BookResponse> getSerchedBookDetail(
      {int perPage,
      int page,
      Sort sort,
      int authorId,
      int categoryId,
      String searchQuery});

  Future addToFavourite(int id);

  Future deleteFavourite(int id);

  Future giveRating(int id, num rating);
}

@provide
@singleton
class BookRepositoryImpl extends BookRepository {
  final UserApiProvider apiProvider;

  BookRepositoryImpl(this.apiProvider);

  @override
  Future<CourcesResponse> getBooks() {
    return apiProvider.getBooks();
  }

  @override
  Future<List<BookCategory>> getCategories() {
    return apiProvider.getBookCategories();
  }

  @override
  Future<CourcesResponse> getBooksById(int id) {
    return apiProvider.getBookById(id);
  }

  @override
  Future<BookDetails> getBook(int id) {
    return apiProvider.getBookDetail(id);
  }

  @override
  Future<BookResponse> getSerchedBookDetail(
      {int perPage,
      int page,
      Sort sort,
      int authorId,
      int categoryId,
      String searchQuery}) {
    Map<String, dynamic> query = Map();
    query.addParam("per_page", perPage);
    query.addParam("page", page);
    query.addParam("author_id", authorId);
    query.addParam("category", categoryId);
    query.addParam("s", searchQuery);
    if (sort != null) {
      var sortValue;
      switch (sort) {
        case Sort.free:
          sortValue = "free";
          break;
        case Sort.date_low:
          sortValue = "date_low";
          break;
        case Sort.price_low:
          sortValue = "price_low";
          break;
        case Sort.price_high:
          sortValue = "price_high";
          break;
        case Sort.rating:
          sortValue = "rating";
          break;
        case Sort.popular:
          sortValue = "popular";
          break;
        case Sort.favorite:
          sortValue = "favorite";
          break;
      }
      query.addParam("sort", sortValue);
    }

    return apiProvider.getSearchedBook(query);
  }

  @override
  Future addToFavourite(int id) {
    return apiProvider.addFavBook(id);
  }

  @override
  Future deleteFavourite(int id) {
    return apiProvider.deleteFavBook(id);
  }

  @override
  Future requestForBook(int id, String notes) {
    return apiProvider.requestBook(id, notes);
  }

  @override
  Future<CourcesResponse> getBookmark() {
    return apiProvider.getBookmarkBook();
  }

  @override
  Future giveRating(int id, num rating) {
    return apiProvider.bookRating(id, rating);
  }
}
