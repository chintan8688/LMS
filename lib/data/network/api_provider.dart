import 'dart:io';

import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';
import 'package:masterstudy_app/data/models/AddToCartResponse.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/data/models/BookCategory.dart';
import 'package:masterstudy_app/data/models/BookDetail.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/FinalResponse.dart';
import 'package:masterstudy_app/data/models/InstructorsResponse.dart';
import 'package:masterstudy_app/data/models/LessonResponse.dart';
import 'package:masterstudy_app/data/models/OrdersResponse.dart';
import 'package:masterstudy_app/data/models/PopularSearchesResponse.dart';
import 'package:masterstudy_app/data/models/QuestionAddResponse.dart';
import 'package:masterstudy_app/data/models/QuestionsResponse.dart';
import 'package:masterstudy_app/data/models/ReviewAddResponse.dart';
import 'package:masterstudy_app/data/models/ReviewResponse.dart';
import 'package:masterstudy_app/data/models/about_us.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/auth.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/data/models/curriculum.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/data/models/purchase/UserPlansResponse.dart';
import 'package:masterstudy_app/data/models/quote.dart';
import 'package:masterstudy_app/data/models/settings.dart';
import 'package:masterstudy_app/data/models/user_course.dart';

import '../models/BookResponse.dart';

@provide
@singleton
class UserApiProvider {
  static const BASE_URL = "http://markaltd.depro15.fcomet.com/kalimahtayebah";
  static const String apiEndpoint = BASE_URL + "/wp-json/ms_lms/v1/";
  final Dio _dio;

  static String AccessToken =
      'IGQVJXYVZAYY0VJWWtMdzlfckt2SGlNenJVbXBtRlpqTGU2Q0lNd2k0eWJHaVJlNFhwRFBNVFlBelZAreVJZAazlDODRvendPZAWlWcUdWMWw0UkF2NmZA6VlZAIcTAwcjBBRUdwZAWc5eUxpa1k0eHdrWWRsTgZDZD';
  static String InstagraFeedAPI =
      'https://graph.instagram.com/me/media?fields=id,media_type,media_url,username,timestamp&access_token=' +
          AccessToken;

  UserApiProvider(this._dio);

  /// Auth
  Future<AuthResponse> authUser(
      String login, String password, String token) async {
    Response response = await _dio.post(apiEndpoint + "login", data: {
      "login": login.trim(),
      "password": password.trim(),
      'device_token': token
    });
    return AuthResponse.fromJson(response.data);
  }

  Future socialLogin(String device_token, String social_login_type,
      String email, String name, String id, String avtar_url) async {
    Response response = await _dio.post(apiEndpoint + "social_login", data: {
      "device_token": device_token,
      "name": name,
      'social_login_type': social_login_type,
      'social_id': id,
      'email': email,
      'avatar_url': avtar_url,
    });
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> signUpUser(
      String login,
      String email,
      String password,
      String phone,
      String phone_code,
      String country,
      DateTime birthDate,
      String token) async {
    print('==: api call');
    Response response = await _dio.post(apiEndpoint + "registration/", data: {
      "name": login.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phone": phone.toString(),
      "phone_code": phone_code.toString(),
      "country": country.toString(),
      "birth_date": (DateFormat('yyyy-MM-dd')).format(birthDate).toString(),
      'device_token': token
    });
    print('==: ${response.data}');
    return AuthResponse.fromJson(response.data);
  }

  Future editProfile(
    String f_name,
    String l_name,
    String email,
    String password,
    String oldPassword,
    String phone,
    String phoneCode,
    DateTime bDate,
    String country,
  ) async {
    Map<String, dynamic> map = {
      "first_name": f_name,
      "last_name": l_name,
      "email": email,
      "phone": phone,
      "phone_code": phoneCode,
      "birth_date": (DateFormat('yyyy-MM-dd').format(bDate)).toString(),
      "country": country,
    };

    if (password.trim() != "" && password != null && password.isNotEmpty)
      map.addAll({"password": password, "old_password": oldPassword});
    print('Password: ${password}');
    Response response = await _dio.post(apiEndpoint + "account/edit_profile/",
        data: map,
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return response.data;
  }

  Future sendBugs(String bugs) async {
    Response response = await _dio.post(
      apiEndpoint + "report_problem",
      data: {"problem": bugs},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future setNotificationSetting(int isNotification) async {
    Response response = await _dio.put(
      apiEndpoint + 'settings',
      data: {'allow_notification': isNotification},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future<SettingsBean> getSetting() async {
    Response response = await _dio.post(
      apiEndpoint + 'settings',
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );

    return SettingsBean.fromJson(response.data);
  }

  Future<InstagramFeedBean> getInstaFeeds() async {
    Response response = await _dio.get(InstagraFeedAPI);
    return InstagramFeedBean.fromJson(response.data);
  }

  Future<QuoteBean> getQuotes() async {
    Response response = await _dio.post(apiEndpoint + 'pages?id=1236');
    return QuoteBean.fromJson(response.data);
  }

  Future<AboutUsBean> getAboutUsInfo() async {
    Response response = await _dio.post(apiEndpoint + 'pages?id=1242');
    return AboutUsBean.fromJson(response.data);
  }

  Future<List<CountryDropdown>> getCountry() async {
    Response response = await _dio.get(apiEndpoint + 'country');
    return (response.data as List)
        .map((e) => CountryDropdown.fromJson(e))
        .toList();
  }

  Future<CourcesResponse> getBooks() async {
    Response response = await _dio.get(apiEndpoint + 'courses?category=${51}');
    return CourcesResponse.fromJson(response.data);
  }

  Future<BookResponse> getSearchedBook(Map<String, dynamic> params) async {
    Response response =
        await _dio.get(apiEndpoint + 'courses', queryParameters: params);
    return BookResponse.fromJson(response.data);
  }

  Future<List<BookCategory>> getBookCategories() async {
    Response response = await _dio.get(apiEndpoint + 'book_categories');

    List<BookCategory> obj = new List<BookCategory>();
    obj = (response.data as List).map((e) => BookCategory.fromJson(e)).toList();

    /*BookCategory newCategory = new BookCategory();
    newCategory.id = -99;
    newCategory.count = 0;
    newCategory.name = 'جميع الخيارات';
    obj.insert(0, newCategory);*/
    return obj;
  }

  Future<CourcesResponse> getBookById(int id) async {
    Response response;

    //if id = -99 then category is all.
    if (id == -99)
      response = await _dio.get(apiEndpoint + 'courses?category=${51}');
    else
      response = await _dio.get(apiEndpoint + 'courses?category=${id}');

    return CourcesResponse.fromJson(response.data);
  }

  Future<CourcesResponse> getBookmarkBook() async {
    print("Bookmark api.....");
    Response response = await _dio.post(apiEndpoint + 'bookmark',
        options: Options(headers: {"requirestoken": "true"}));
    return CourcesResponse.fromJson(response.data);
  }

  Future<BookDetails> getBookDetail(int id) async {
    Response response = await _dio.get(apiEndpoint + 'course?id=${id}',
        options: Options(headers: {"requirestoken": "true"}));
    return BookDetails.fromJson(response.data);
  }

  Future<BookDetails> addFavBook(int id) async {
    Response response = await _dio.put(
      apiEndpoint + "bookmark",
      queryParameters: {"id": id},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future<BookDetails> deleteFavBook(int id) async {
    Response response = await _dio.delete(
      apiEndpoint + "bookmark",
      queryParameters: {"id": id},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future requestBook(int id, String notes) async {
    Response response = await _dio.post(
      apiEndpoint + 'book_request',
      data: {"book_id": id, "notes": notes},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future bookRating(int id, num rating) async {
    Response response = await _dio.post(
      apiEndpoint + 'book_rating',
      data: {"book_id": id, "rating": rating},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
  }

  Future<List<Category>> getCategories() async {
    Response response = await _dio.get(apiEndpoint + "categories/");

    List<Category> list = new List();
    list = (response.data as List).map((value) {
      return Category.fromJson(value);
    }).toList();

    Category newCategory = new Category();
    newCategory.id = -99;
    newCategory.count = 0;
    newCategory.name = 'جميع الخيارات';
    list.insert(0, newCategory);
    return list;
  }

  Future<AppSettings> getAppSettings() async {
    Response response = await _dio.get(apiEndpoint + "app_settings/");
    return AppSettings.fromJson(response.data);
  }

  Future<CourcesResponse> getCourses(Map<String, dynamic> params) async {
    /*Response response =
        await _dio.get(apiEndpoint + "courses/", queryParameters: params);
    return CourcesResponse.fromJson(response.data);*/

    Response response;

    if (params['category'] == -99)
      response = await _dio.get(apiEndpoint + "courses/");
    else
      response =
          await _dio.get(apiEndpoint + "courses/", queryParameters: params);

    return CourcesResponse.fromJson(response.data);
  }

  Future<CourcesResponse> getFavoriteCourses() async {
    Response response = await _dio.get(
      apiEndpoint + "courses/",
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
    return CourcesResponse.fromJson(response.data);
  }

  Future addFavoriteCourse(int courseId) async {
    Response response = await _dio.put(
      apiEndpoint + "favorite",
      queryParameters: {"id": courseId},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
    return CourcesResponse.fromJson(response.data);
  }

  Future deleteFavoriteCourse(int courseId) async {
    Response response = await _dio.delete(
      apiEndpoint + "favorite",
      queryParameters: {"id": courseId},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
    return CourcesResponse.fromJson(response.data);
  }

  Future<InstructorsResponse> getInstructors(
      Map<String, dynamic> params) async {
    Response response =
        await _dio.get(apiEndpoint + "instructors/", queryParameters: params);
    return InstructorsResponse.fromJson(response.data);
  }

  Future<Account> getAccount({int accountId}) async {
    var params;
    if (accountId != null) params = {"id": accountId};
    Response response = await _dio.post(apiEndpoint + "account/",
        queryParameters: params,
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return Account.fromJson(response.data);
  }

  Future uploadProfilePhoto(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    Response response = await _dio.post(apiEndpoint + "account/edit_profile/",
        data: formData,
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return response.data;
  }

  Future<CourseDetailResponse> getCourse(int id) async {
    Response response = await _dio.post(apiEndpoint + "course?id=${id}",
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return CourseDetailResponse.fromJson(response.data);
  }

  Future<ReviewResponse> getReviews(int id) async {
    Response response = await _dio.get(
      apiEndpoint + "course_reviews",
      queryParameters: {"id": id},
    );
    return ReviewResponse.fromJson(response.data);
  }

  Future<ReviewAddResponse> addReviews(int id, int mark, String review) async {
    Response response = await _dio.post(apiEndpoint + "course_reviews",
        queryParameters: {"id": id, "mark": mark, "review": review},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return ReviewAddResponse.fromJson(response.data);
  }

  Future<UserCourseResponse> getUserCourses() async {
    Response response = await _dio.post(apiEndpoint + "user_courses?page=0",
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return UserCourseResponse.fromJson(response.data);
  }

  Future<CurriculumResponse> getCourseCurriculum(int id) async {
    Response response =
        await _dio.post(apiEndpoint + "course_curriculum?page=0",
            data: {"id": id},
            options: Options(
              headers: {"requirestoken": "true"},
            ));
    return CurriculumResponse.fromJson(response.data);
  }

  Future<AssignmentResponse> getAssignmentInfo(
      int course_id, int assignment_id) async {
    Map<String, int> map = {
      "course_id": course_id,
      "assignment_id": assignment_id,
    };

    Response response = await _dio.post(apiEndpoint + "assignment",
        data: map,
        options: Options(
          headers: {"requirestoken": "true"},
        ));

    return AssignmentResponse.fromJson(response.data);
  }

  Future<AssignmentResponse> startAssignment(
      int course_id, int assignment_id) async {
    Map<String, int> map = {
      "course_id": course_id,
      "assignment_id": assignment_id,
    };

    Response response = await _dio.put(apiEndpoint + "assignment/start",
        data: map,
        options: Options(
          headers: {"requirestoken": "true"},
        ));

    return AssignmentResponse.fromJson(response.data);
  }

  Future<AssignmentResponse> addAssignment(
      int course_id, int user_assignment_id, String content) async {
    Map<String, dynamic> map = {
      "course_id": course_id,
      "user_assignment_id": user_assignment_id,
      "content": content,
    };

    Response response = await _dio.post(apiEndpoint + "assignment/add",
        data: map,
        options: Options(
          headers: {"requirestoken": "true"},
        ));

    return AssignmentResponse.fromJson(response.data);
  }

  Future<String> uploadAssignmentFile(
      int course_id, int user_assignment_id, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "course_id": course_id,
      "user_assignment_id": user_assignment_id,
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    Response response = await _dio.post(apiEndpoint + "assignment/add/file",
        data: formData,
        options: Options(
          headers: {"requirestoken": "true"},
        ));
  }

  Future<LessonResponse> getLesson(int courseId, int lessonId) async {
    Response response = await _dio.post(apiEndpoint + "course/lesson",
        data: {"course_id": courseId, "item_id": lessonId},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return LessonResponse.fromJson(response.data);
  }

  Future completeLesson(int courseId, int lessonId) async {
    Response response = await _dio.put(apiEndpoint + "course/lesson/complete",
        data: {"course_id": courseId, "item_id": lessonId},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return;
  }

  Future<LessonResponse> getQuiz(int courseId, int lessonId) async {
    Response response = await _dio.post(apiEndpoint + "course/quiz",
        data: {"course_id": courseId, "item_id": lessonId},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return LessonResponse.fromJson(response.data);
  }

  Future<QuestionsResponse> getQuestions(
      int lessonId, int page, String search, String authorIn) async {
    Map<String, dynamic> map = {
      "id": lessonId,
      "page": page,
    };

    if (search != "") map['search'] = search;
    if (authorIn != "") map['author__in'] = authorIn;

    Response response = await _dio.post(apiEndpoint + "lesson/questions",
        data: map,
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return QuestionsResponse.fromJson(response.data);
  }

  Future<QuestionAddResponse> addQuestion(
      int lessonId, String comment, int parent) async {
    Response response = await _dio.put(apiEndpoint + "lesson/questions",
        data: {"id": lessonId, "comment": comment, "parent": parent},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return QuestionAddResponse.fromJson(response.data);
  }

  Future<PopularSearchesResponse> popularSearches(int limit) async {
    Response response = await _dio.get(apiEndpoint + "popular_searches",
        queryParameters: {"limit": limit});
    return PopularSearchesResponse.fromJson(response.data);
  }

  Future<UserPlansResponse> getUserPlans() async {
    Response response = await _dio.post(apiEndpoint + "user_plans",
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return UserPlansResponse.fromJsonArray(response.data);
  }

  Future<UserPlansResponse> getPlans() async {
    Response response = await _dio.get(apiEndpoint + "plans",
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return UserPlansResponse.fromJsonArray(response.data);
  }

  Future<OrdersResponse> getOrders() async {
    Response response = await _dio.post(apiEndpoint + "user_orders",
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return OrdersResponse.fromJsonArray(response.data["posts"]);
  }

  Future<AddToCartResponse> addToCart(int courseId) async {
    Response response = await _dio.put(apiEndpoint + "add_to_cart",
        data: {"id": courseId},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    return AddToCartResponse.fromJson(response.data);
  }

  Future<bool> usePlan(int courseId, int subscriptionId) async {
    Response response = await _dio.put(apiEndpoint + "use_plan",
        data: {"course_id": courseId, "subscription_id": subscriptionId},
        options: Options(
          headers: {"requirestoken": "true"},
        ));
    if (response.statusCode == 200) return true;
  }

  Future<Map<String, dynamic>> getLocalization() async {
    var data = await _dio.get(UserApiProvider.apiEndpoint + "translations");
    if (data.statusCode == 200) return Future.value(data.data);
    return Future.error("");
  }

  Future<FinalResponse> getCourseResults(int courseId) async {
    Response response = await _dio.post(
      apiEndpoint + "course/results",
      data: {"course_id": courseId},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
    return FinalResponse.fromJson(response.data);
  }

  Future<String> demoAuth() async {
    Response response = await _dio.get(
      apiEndpoint + "demo",
    );
    return response.data['token'];
  }

  Future<Response> restorePassword(String email) async {
    Response response = await _dio
        .post(apiEndpoint + "account/restore_password", data: {"email": email});
    print('==: ${response.data}');
    return response;
  }

  Future<bool> verifyInApp(String serverVerificationData, String price) async {
    Response respose = await _dio.post(
      apiEndpoint + "verify_purchase",
      data: {"receipt": serverVerificationData, "price": price},
      options: Options(
        headers: {"requirestoken": "true"},
      ),
    );
    if (respose.statusCode == 200) return true;
    return false;
  }
}
