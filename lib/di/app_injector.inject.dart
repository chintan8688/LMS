import 'app_injector.dart' as _i1;
import 'modules.dart' as _i2;
import 'package:dio/src/dio.dart' as _i3;
import '../data/network/api_provider.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i5;
import '../data/repository/auth_repository.dart' as _i6;
import '../data/repository/home_repository.dart' as _i7;
import '../data/repository/courses_repository.dart' as _i8;
import '../data/repository/instructors_repository.dart' as _i9;
import '../data/repository/review_respository.dart' as _i10;
import '../data/repository/assignment_repository.dart' as _i11;
import '../data/cache/cache_manager.dart' as _i12;
import '../data/repository/questions_repository.dart' as _i13;
import '../data/repository/final_repository.dart' as _i14;
import 'dart:async' as _i15;
import '../main.dart' as _i16;
import '../ui/screen/signup/signup_screen.dart' as _i17;
import '../ui/bloc/auth/auth_bloc.dart' as _i18;
import '../ui/bloc/home/home_bloc.dart' as _i19;
import '../ui/screen/splash/splash_screen.dart' as _i20;
import '../ui/bloc/splash/splash_bloc.dart' as _i21;
import '../ui/bloc/favorites/favorites_bloc.dart' as _i22;
import '../ui/bloc/profile/profile_bloc.dart' as _i23;
import '../data/repository/account_repository.dart' as _i24;
import '../ui/bloc/edit_profile_bloc/edit_profile_bloc.dart' as _i25;
import '../ui/bloc/detail_profile/detail_profile_bloc.dart' as _i26;
import '../ui/bloc/search/search_screen_bloc.dart' as _i27;
import '../ui/bloc/search_detail/search_detail_bloc.dart' as _i28;
import '../ui/bloc/course/course_bloc.dart' as _i29;
import '../data/repository/purchase_repository.dart' as _i30;
import '../ui/bloc/home_simple/home_simple_bloc.dart' as _i31;
import '../ui/bloc/category_detail/category_detail_bloc.dart' as _i32;
import '../ui/bloc/profile_assignment/profile_assignment_bloc.dart' as _i33;
import '../ui/bloc/assignment/assignment_bloc.dart' as _i34;
import '../ui/bloc/review_write/review_write_bloc.dart' as _i35;
import '../ui/bloc/courses/user_courses_bloc.dart' as _i36;
import '../data/repository/user_course_repository.dart' as _i37;
import '../ui/bloc/user_course/user_course_bloc.dart' as _i38;
import '../data/repository/lesson_repository.dart' as _i39;
import '../ui/bloc/user_course_locked/user_course_locked_bloc.dart' as _i40;
import '../ui/bloc/text_lesson/text_lesson_bloc.dart' as _i41;
import '../ui/bloc/quiz_lesson/quiz_lesson_bloc.dart' as _i42;
import '../ui/bloc/lesson_video/lesson_video_bloc.dart' as _i43;
import '../ui/bloc/lesson_stream/lesson_stream_bloc.dart' as _i44;
import '../ui/bloc/video/video_bloc.dart' as _i45;
import '../ui/bloc/questions/questions_bloc.dart' as _i46;
import '../ui/bloc/question_ask/question_ask_bloc.dart' as _i47;
import '../ui/bloc/question_details/question_details_bloc.dart' as _i48;
import '../ui/bloc/quiz_screen/quiz_screen_bloc.dart' as _i49;
import '../ui/bloc/final/final_bloc.dart' as _i50;
import '../ui/bloc/plans/plans_bloc.dart' as _i51;
import '../ui/bloc/orders/orders_bloc.dart' as _i52;
import '../ui/bloc/restore_password/restore_password_bloc.dart' as _i53;
import '../ui/screen/home/home_screen.dart' as _i54;
import '../ui/screen/login/login_Screen.dart' as _i55;
import 'package:masterstudy_app/ui/screen/books/books_screen.dart' as _i56;
import 'package:masterstudy_app/ui/screen/book_detail/book_detail_Screen.dart'
    as _i57;
import 'package:masterstudy_app/ui/screen/book_section/book_Section_screen.dart'
    as _i58;
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart' as _i59;
import 'package:masterstudy_app/data/repository/book_repository.dart' as _i60;
import 'package:masterstudy_app/ui/bloc/books/books_block.dart' as _i61;
import 'package:masterstudy_app/ui/bloc/book_detail/book_detail_bloc.dart'
    as _i62;
import 'package:masterstudy_app/ui/bloc/book_search_detail/book_search_detail_bloc.dart'
    as _i63;
import 'package:masterstudy_app/ui/screen/book_search_detail/book_search_detail_screen.dart'
    as _i64;
import 'package:masterstudy_app/ui/screen/rootwelcome/root_welcome_screen.dart'
    as _i65;
import 'package:masterstudy_app/ui/screen/quote_screen/quote_screen.dart'
    as _i66;
import 'package:masterstudy_app/ui/screen/donation_screen/donation_screen.dart'
    as _i67;
import 'package:masterstudy_app/ui/screen/setting_screen/setting_screen.dart'
    as _i68;
import 'package:masterstudy_app/ui/screen/profile_screen/profile_screen.dart'
    as _i69;
import 'package:masterstudy_app/ui/screen/books_bookmark/books_bookmark_screen.dart'
    as _i70;
import 'package:masterstudy_app/ui/screen/about_us/about_us_screen.dart'
    as _i71;
import 'package:masterstudy_app/ui/screen/instagram_feed/instagram_feed_screen.dart'
    as _i72;
import 'package:masterstudy_app/data/repository/instagram_feed_repository.dart'
    as _i73;
import 'package:masterstudy_app/ui/bloc/instagram_feed/instagram_feed_bloc.dart'
    as _i74;
import 'package:masterstudy_app/ui/bloc/about_us/about_us_bloc.dart' as _i75;
import 'package:masterstudy_app/data/repository/about_us_repository.dart'
    as _i76;
import 'package:masterstudy_app/ui/bloc/quote/quote_bloc.dart' as _i77;
import 'package:masterstudy_app/data/repository/quote_repository.dart' as _i78;
import 'package:masterstudy_app/ui/screen/instagram_feed_detail/instagram_feed_detail_screen.dart'
    as _i79;
import 'package:masterstudy_app/ui/bloc/setting/setting_bloc.dart' as _i80;
import 'package:masterstudy_app/data/repository/setting_repository.dart'
    as _i81;
import 'package:masterstudy_app/ui/bloc/book_bookmark/book_bookmark_bloc.dart'
    as _i82;
import 'package:masterstudy_app/ui/bloc/lesson_audio/lesson_audio_bloc.dart'
    as _i83;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._appModule);

  final _i2.AppModule _appModule;

  _i3.Dio _singletonDio;

  _i4.UserApiProvider _singletonUserApiProvider;

  _i5.SharedPreferences _sharedPreferences;

  _i6.AuthRepository _singletonAuthRepository;

  _i7.HomeRepository _singletonHomeRepository;

  _i8.CoursesRepository _singletonCoursesRepository;

  _i9.InstructorsRepository _singletonInstructorsRepository;

  _i10.ReviewRepository _singletonReviewRepository;

  _i11.AssignmentRepository _singletonAssignmentRepository;

  _i12.CacheManager _singletonCacheManager;

  _i13.QuestionsRepository _singletonQuestionsRepository;

  _i14.FinalRepository _singletonFinalRepository;

  _i60.BookRepository _singletonBookRepository;

  _i73.FeedRepository _singletonFeedRepository;

  _i76.AboutUsRepository _singletonAboutUsRepository;

  _i78.QuoteRepository _singletonQuoteRepository;
  _i81.SettingRepository _singletonSettingRepository;

  static _i15.Future<_i1.AppInjector> create(_i2.AppModule appModule) async {
    final injector = AppInjector$Injector._(appModule);
    injector._sharedPreferences =
        await injector._appModule.provideSharedPreferences();
    return injector;
  }

  _i16.MyApp _createMyApp() => _i16.MyApp(
        _createSignUpScreen,
        _createLoginScreen,
        _createHomeScreen,
        _createHomeBloc,
        _createSplashScreen,
        _createFavoritesBloc,
        _createProfileBloc,
        _createEditProfileBloc,
        _createDetailProfileBloc,
        _createSearchScreenBloc,
        _createSearchDetailBloc,
        _createCourseBloc,
        _createHomeSimpleBloc,
        _createCategoryDetailBloc,
        _createProfileAssignmentBloc,
        _createAssignmentBloc,
        _createReviewWriteBloc,
        _createUserCoursesBloc,
        _createUserCourseBloc,
        _createUserCourseLockedBloc,
        _createTextLessonBloc,
        _createQuizLessonBloc,
        _createLessonVideoBloc,
        _createLessonStreamBloc,
        _createVideoBloc,
        _createQuestionsBloc,
        _createQuestionAskBloc,
        _createQuestionDetailsBloc,
        _createQuizScreenBloc,
        _createFinalBloc,
        _createPlansBloc,
        _createOrdersBloc,
        _createRestorePasswordBloc,
        _createBookScreen,
        //_createBookDetailScreen,
        _createBookSectionScreen,
        _createWelcomeScreen,
        _createBookBlock,
        _createBookDetailBloc,
        //_createBookSearchDetailScreen,
        _createBookSearchDetailBloc,
        _createRootWelcomeScreen,
        _createQuoteScreen,
        _createDonateScreen,
        _createSettingScreen,
        _createProfileScreen,
        _createBooksBookmarkScreen,
        _createAboutUsScreen,
        _createInstagramFeed,
        _createFeedRepository,
        _createFeedBloc,
        _createAboutUsBloc,
        _createAboutUsRepository,
        _createQuoteBloc,
        _createQuoteRepository,
        _createFeedDetailScreen,
        _createSettingBloc,
        _createSettingRepository,
        _createBookmarkBloc,
        _createLessonAudioBloc,
      );

  _i17.SignUpScreen _createSignUpScreen() =>
      _i17.SignUpScreen(_createAuthBloc(), _createSharedPreferences());

  _i55.LoginScreen _createLoginScreen() =>
      _i55.LoginScreen(_createAuthBloc(), _createSharedPreferences());

  _i18.AuthBloc _createAuthBloc() =>
      _appModule.provideAuthBloc(_createAuthRepository());

  _i6.AuthRepository _createAuthRepository() =>
      _singletonAuthRepository ??= _appModule.userRepository(
          _createUserApiProvider(), _createSharedPreferences());

  _i4.UserApiProvider _createUserApiProvider() => _singletonUserApiProvider ??=
      _appModule.provideUserApiProvider(_createDio());

  _i3.Dio _createDio() => _singletonDio ??= _appModule.provideDio();

  _i5.SharedPreferences _createSharedPreferences() => _sharedPreferences;

  _i19.HomeBloc _createHomeBloc() => _i19.HomeBloc(_createHomeRepository(),
      _createCoursesRepository(), _createInstructorsRepository());

  _i7.HomeRepository _createHomeRepository() =>
      _singletonHomeRepository ??= _appModule.homeRepository(
          _createUserApiProvider(), _createSharedPreferences());

  _i8.CoursesRepository _createCoursesRepository() =>
      _singletonCoursesRepository ??=
          _appModule.coursesRepository(_createUserApiProvider());

  _i9.InstructorsRepository _createInstructorsRepository() =>
      _singletonInstructorsRepository ??=
          _appModule.instructorsRepository(_createUserApiProvider());

  _i20.SplashScreen _createSplashScreen() =>
      _i20.SplashScreen(_createSplashBloc());

  _i21.SplashBloc _createSplashBloc() => _appModule.provideSplashBloc(
      _createAuthRepository(),
      _createHomeRepository(),
      _createUserApiProvider());

  _i22.FavoritesBloc _createFavoritesBloc() =>
      _i22.FavoritesBloc(_createCoursesRepository());

  _i23.ProfileBloc _createProfileBloc() =>
      _i23.ProfileBloc(_createAccountRepository(), _createAuthRepository());

  _i24.AccountRepository _createAccountRepository() =>
      _appModule.provideAccountRepository(_createUserApiProvider());

  _i25.EditProfileBloc _createEditProfileBloc() =>
      _i25.EditProfileBloc(_createAccountRepository());

  _i26.DetailProfileBloc _createDetailProfileBloc() => _i26.DetailProfileBloc(
      _createAccountRepository(), _createCoursesRepository());

  _i27.SearchScreenBloc _createSearchScreenBloc() =>
      _i27.SearchScreenBloc(_createCoursesRepository());

  _i28.SearchDetailBloc _createSearchDetailBloc() =>
      _i28.SearchDetailBloc(_createCoursesRepository());

  _i29.CourseBloc _createCourseBloc() => _i29.CourseBloc(
      _createCoursesRepository(),
      _createReviewRepository(),
      _createPurchaseRepository());

  _i10.ReviewRepository _createReviewRepository() =>
      _singletonReviewRepository ??=
          _appModule.reviewRepository(_createUserApiProvider());

  _i30.PurchaseRepository _createPurchaseRepository() =>
      _appModule.providePurchaseRepository(_createUserApiProvider());

  _i31.HomeSimpleBloc _createHomeSimpleBloc() =>
      _i31.HomeSimpleBloc(_createCoursesRepository());

  _i32.CategoryDetailBloc _createCategoryDetailBloc() =>
      _i32.CategoryDetailBloc(
          _createHomeRepository(), _createCoursesRepository());

  _i33.ProfileAssignmentBloc _createProfileAssignmentBloc() =>
      _i33.ProfileAssignmentBloc();

  _i34.AssignmentBloc _createAssignmentBloc() =>
      _i34.AssignmentBloc(_createAssignmentRepository(), _createCacheManager());

  _i11.AssignmentRepository _createAssignmentRepository() =>
      _singletonAssignmentRepository ??=
          _appModule.assignmentRepository(_createUserApiProvider());

  _i12.CacheManager _createCacheManager() =>
      _singletonCacheManager ??= _i12.CacheManager();

  _i35.ReviewWriteBloc _createReviewWriteBloc() => _i35.ReviewWriteBloc(
      _createAccountRepository(), _createReviewRepository());

  _i36.UserCoursesBloc _createUserCoursesBloc() => _i36.UserCoursesBloc(
      _createUserCourseRepository(), _createCacheManager());

  _i38.UserCourseBloc _createUserCourseBloc() => _i38.UserCourseBloc(
      _createUserCourseRepository(),
      _createCacheManager(),
      _createLessonRepository());

  _i37.UserCourseRepository _createUserCourseRepository() =>
      _appModule.provideUserCourseRepository(
          _createUserApiProvider(), _createCacheManager());

  _i39.LessonRepository _createLessonRepository() => _appModule
      .provideLessonRepository(_createUserApiProvider(), _createCacheManager());

  _i40.UserCourseLockedBloc _createUserCourseLockedBloc() =>
      _i40.UserCourseLockedBloc(_createUserCourseRepository());

  _i41.TextLessonBloc _createTextLessonBloc() =>
      _i41.TextLessonBloc(_createLessonRepository(), _createCacheManager());

  _i42.QuizLessonBloc _createQuizLessonBloc() =>
      _i42.QuizLessonBloc(_createLessonRepository(), _createCacheManager());

  _i43.LessonVideoBloc _createLessonVideoBloc() =>
      _i43.LessonVideoBloc(_createLessonRepository());

  _i83.LessonAudioBloc _createLessonAudioBloc() =>
      _i83.LessonAudioBloc(_createLessonRepository());

  _i44.LessonStreamBloc _createLessonStreamBloc() =>
      _i44.LessonStreamBloc(_createLessonRepository(), _createCacheManager());

  _i45.VideoBloc _createVideoBloc() => _i45.VideoBloc();

  _i46.QuestionsBloc _createQuestionsBloc() =>
      _i46.QuestionsBloc(_createQuestionsRepository());

  _i13.QuestionsRepository _createQuestionsRepository() =>
      _singletonQuestionsRepository ??=
          _appModule.questionsRepository(_createUserApiProvider());

  _i47.QuestionAskBloc _createQuestionAskBloc() =>
      _i47.QuestionAskBloc(_createQuestionsRepository());

  _i48.QuestionDetailsBloc _createQuestionDetailsBloc() =>
      _i48.QuestionDetailsBloc(_createQuestionsRepository());

  _i49.QuizScreenBloc _createQuizScreenBloc() =>
      _appModule.provideQuizScreenBloc(_createLessonRepository());

  _i50.FinalBloc _createFinalBloc() =>
      _i50.FinalBloc(_createFinalRepository(), _createCacheManager());

  _i14.FinalRepository _createFinalRepository() => _singletonFinalRepository ??=
      _appModule.finalRepository(_createUserApiProvider());

  _i51.PlansBloc _createPlansBloc() =>
      _i51.PlansBloc(_createPurchaseRepository());

  _i52.OrdersBloc _createOrdersBloc() =>
      _i52.OrdersBloc(_createPurchaseRepository());

  _i53.RestorePasswordBloc _createRestorePasswordBloc() =>
      _i53.RestorePasswordBloc(_createAuthRepository());

  _i54.HomeScreen _createHomeScreen() => _i54.HomeScreen();

  _i56.BookScreen _createBookScreen() => _i56.BookScreen(_createBookBlock());

  _i70.BooksBookmark _createBooksBookmarkScreen() =>
      _i70.BooksBookmark(_createBookmarkBloc());

  /*_i57.BookDetail _createBookDetailScreen() =>
      _i57.BookDetail(_createBookDetailBloc());*/

  _i58.BookSection _createBookSectionScreen() =>
      _i58.BookSection(_createCourseBloc());

  _i59.WelcomeScreen _createWelcomeScreen() => _i59.WelcomeScreen();

  _i61.BookBlock _createBookBlock() => _i61.BookBlock(_createBookRepository());

  _i82.BookBookmarkBloc _createBookmarkBloc() =>
      _i82.BookBookmarkBloc(_createBookRepository());

  _i62.BookDetailBlock _createBookDetailBloc() =>
      _i62.BookDetailBlock(_createBookRepository());

  /*_i64.BookSearchDetailScreen _createBookSearchDetailScreen() =>
      _i64.BookSearchDetailScreen(_createBookSearchDetailBloc());*/

  _i63.BookSearchDetailBloc _createBookSearchDetailBloc() =>
      _i63.BookSearchDetailBloc(_createBookRepository());

  _i60.BookRepository _createBookRepository() => _singletonBookRepository ??=
      _appModule.bookRepository(_createUserApiProvider());

  _i65.RootWelcomeScreen _createRootWelcomeScreen() =>
      _i65.RootWelcomeScreen(_createAuthBloc(), _createSharedPreferences());

  _i66.QuoteScreen _createQuoteScreen() => _i66.QuoteScreen(_createQuoteBloc());

  _i77.QuoteBloc _createQuoteBloc() => _i77.QuoteBloc(_createQuoteRepository());

  _i78.QuoteRepository _createQuoteRepository() => _singletonQuoteRepository ??=
      _appModule.quoteRepository(_createUserApiProvider());

  _i67.DonateScreen _createDonateScreen() => _i67.DonateScreen();

  _i68.SettingScreen _createSettingScreen() =>
      _i68.SettingScreen(_createSettingBloc());

  _i80.SettingBloc _createSettingBloc() =>
      _i80.SettingBloc(_createSettingRepository());

  _i81.SettingRepository _createSettingRepository() =>
      _singletonSettingRepository ??=
          _appModule.settingRepository(_createUserApiProvider());

  _i69.ProfileScreen _createProfileScreen() =>
      _i69.ProfileScreen(_createProfileBloc());

  _i71.AboutUs _createAboutUsScreen() => _i71.AboutUs(_createAboutUsBloc());

  _i75.AboutUsBloc _createAboutUsBloc() =>
      _i75.AboutUsBloc(_createAboutUsRepository());

  _i76.AboutUsRepository _createAboutUsRepository() =>
      _singletonAboutUsRepository ??=
          _appModule.aboutUsRepository(_createUserApiProvider());

  _i72.InstagramFeed _createInstagramFeed() =>
      _i72.InstagramFeed(_createFeedBloc());

  _i74.FeedBlock _createFeedBloc() =>
      _i74.FeedBlock(_createFeedRepository(), _createAccountRepository());

  _i73.FeedRepository _createFeedRepository() => _singletonFeedRepository ??=
      _appModule.feedRepository(_createUserApiProvider());

  _i79.FeedDetailScreen _createFeedDetailScreen() => _i79.FeedDetailScreen();

  @override
  _i16.MyApp get app => _createMyApp();

  _i17.SignUpScreen get signUpScreen => _createSignUpScreen();

  _i55.LoginScreen get loginScreen => _createLoginScreen();

  _i56.BookScreen get bookScreen => _createBookScreen();

  /*_i57.BookDetail get bookDetail => _createBookDetailScreen();*/

  _i58.BookSection get bookSection => _createBookSectionScreen();

  _i59.WelcomeScreen get welcomeScreen => _createWelcomeScreen();

  @override
  _i54.HomeScreen get homeScreen => _createHomeScreen();

  @override
  _i20.SplashScreen get splashScreen => _createSplashScreen();

  @override
  _i65.RootWelcomeScreen get rootWelcomeScreen => _createRootWelcomeScreen();

  _i66.QuoteScreen get quoteScreen => _createQuoteScreen();

  _i67.DonateScreen get donateScreen => _createDonateScreen();

  @override
  _i68.SettingScreen get settingScreen => _createSettingScreen();

  @override
  _i69.ProfileScreen get profileScreen => _createProfileScreen();

  @override
  _i70.BooksBookmark get booksBookmark => _createBooksBookmarkScreen();

  @override
  _i71.AboutUs get aboutUs => _createAboutUsScreen();

  @override
  _i72.InstagramFeed get instagramFeed => _createInstagramFeed();

  @override
  _i79.FeedDetailScreen get feedDetail => _createFeedDetailScreen();
}
