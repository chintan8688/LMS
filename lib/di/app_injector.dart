import 'package:inject/inject.dart';
import 'package:masterstudy_app/di/modules.dart';
import 'package:masterstudy_app/ui/screen/books_bookmark/books_bookmark_screen.dart';
import 'package:masterstudy_app/ui/screen/donation_screen/donation_screen.dart';
import 'package:masterstudy_app/ui/screen/instagram_feed/instagram_feed_screen.dart';
import 'package:masterstudy_app/ui/screen/instagram_feed_detail/instagram_feed_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/profile_screen/profile_screen.dart';
import 'package:masterstudy_app/ui/screen/quote_screen/quote_screen.dart';
import 'package:masterstudy_app/ui/screen/rootwelcome/root_welcome_screen.dart';
import 'package:masterstudy_app/ui/screen/setting_screen/setting_screen.dart';
import 'package:masterstudy_app/ui/screen/signup/signup_screen.dart';
import 'package:masterstudy_app/ui/screen/home/home_screen.dart';
import 'package:masterstudy_app/ui/screen/splash/splash_screen.dart';
import 'package:masterstudy_app/ui/screen/login/login_Screen.dart';
import 'package:masterstudy_app/ui/screen/books/books_screen.dart';
import 'package:masterstudy_app/ui/screen/book_detail/book_detail_Screen.dart';
import 'package:masterstudy_app/ui/screen/book_section/book_Section_screen.dart';
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart';
import 'package:masterstudy_app/ui/screen/about_us/about_us_screen.dart';

import '../main.dart';
import 'app_injector.inject.dart' as g;

@Injector(const [AppModule])
abstract class AppInjector {
  @provide
  MyApp get app;

  @provide
  SignUpScreen get signUpScreen;

  @provide
  HomeScreen get homeScreen;

  @provide
  LoginScreen get loginScreen;

  @provide
  SplashScreen get splashScreen;

  @provide
  BookScreen get bookScreen;

  @provide
  //BookDetail get bookDetail;

  @provide
  BookSection get bookSection;

  @provide
  WelcomeScreen get welcomeScreen;

  @provide
  RootWelcomeScreen get rootWelcomeScreen;

  @provide
  QuoteScreen get quoteScreen;

  @provide
  DonateScreen get donateScreen;

  @provide
  SettingScreen get settingScreen;

  @provide
  ProfileScreen get profileScreen;

  @provide
  BooksBookmark get booksBookmark;

  @provide
  AboutUs get aboutUs;

  @provide
  InstagramFeed get instagramFeed;

  @provide
  FeedDetailScreen get feedDetail;

  static Future<AppInjector> create() {
    return g.AppInjector$Injector.create(AppModule());
  }
}
