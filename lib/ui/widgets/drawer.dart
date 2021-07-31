import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/profile/bloc.dart';
import 'package:masterstudy_app/ui/screen/about_us/about_us_screen.dart';
import 'package:masterstudy_app/ui/screen/books/books_screen.dart';
import 'package:masterstudy_app/ui/screen/books_bookmark/books_bookmark_screen.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/courses/courses_screen.dart';
import 'package:masterstudy_app/ui/screen/donation_screen/donation_screen.dart';
import 'package:masterstudy_app/ui/screen/profile_screen/profile_screen.dart';
import 'package:masterstudy_app/ui/screen/quote_screen/quote_screen.dart';
import 'package:masterstudy_app/ui/screen/setting_screen/setting_screen.dart';
import 'package:masterstudy_app/ui/screen/splash/splash_screen.dart';
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerScreenState();
  }
}

class DrawerScreenState extends State<DrawerScreen> {
  final double icon_height = 30, icon_width = 30, font_size = 14;
  String avatarUrl;

  @override
  void initState() {
    super.initState();
    getUserAvatar();
  }

  getUserAvatar() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      avatarUrl = _pref.getString("avatarUrl");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _block = BlocProvider.of<ProfileBloc>(context);
    return BlocListener(
      bloc: _block,
      listener: (context, state) {
        if (state is LogoutProfileState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              SplashScreen.routeName, (Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          return MediaQuery.of(context).size.height >= 600
              ? Container(
                  width: 185,
                  child: Drawer(
                      child: Container(
                    color: HexColor.fromHex('#2f3c6e'),
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Image.asset(
                                    'assets/icons/drawer-close-icon.png',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 14, bottom: 10, top: 10),
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: ClipOval(
                                            child: avatarUrl != null
                                                ? CachedNetworkImage(
                                                    imageUrl: avatarUrl,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                  )
                                                : Container(
                                                    color: Colors.blue,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/courses-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'user_courses'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CoursesScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/home-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations
                                                .getLocalization('homepage'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              WelcomeScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/courses-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                          localizations.getLocalization(
                                              'burger_menu_courses'),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: font_size,
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              CategoryDetailScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/book-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_books'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamed(BookScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/bookmark-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_bookmark'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              BooksBookmark.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/donate-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_donate'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              DonateScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/qoute-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_quote'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamed(QuoteScreen.routeName);
                                        },
                                      ),
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/about-us-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_about'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamed(AboutUs.routeName);
                                        },
                                      ),
                                      /*ListTile(
                                  leading: Image.asset(
                                      'assets/icons/instagram-icon.png',
                                      height: icon_height,
                                      width: icon_width,
                                      fit: BoxFit.contain),
                                  title: Text('تغذية الانستغرام',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(InstagramFeed.routeName);
                                  },
                                ),*/
                                      ListTile(
                                        leading: Image.asset(
                                            'assets/icons/settings-icon.png',
                                            height: icon_height,
                                            width: icon_width,
                                            fit: BoxFit.contain),
                                        title: Text(
                                            localizations.getLocalization(
                                                'burger_menu_setting'),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: font_size,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              SettingScreen.routeName);
                                        },
                                      ),
                                      Container(
                                        child: ListTile(
                                          leading: Image.asset(
                                              'assets/icons/user-icon.png',
                                              height: icon_height,
                                              width: icon_width,
                                              fit: BoxFit.contain),
                                          title: Text(
                                              localizations.getLocalization(
                                                  'burger_menu_profile'),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: font_size,
                                                  color: Colors.white)),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamed(
                                                ProfileScreen.routeName);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/icons/logout-icon.png',
                                        height: icon_height,
                                        width: icon_width,
                                        fit: BoxFit.contain),
                                    onTap: () {
                                      showLogoutDialog(context, _block);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20, left: 16),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          if (await canLaunch(
                                              localizations.getLocalization(
                                                  "youtube_link"))) {
                                            await launch(
                                                localizations.getLocalization(
                                                    "youtube_link"));
                                          } else {
                                            throw 'Could not launch';
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: SvgPicture.asset(
                                            "assets/icons/youtube-icon.svg",
                                            height: 26,
                                            width: 26,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (await canLaunch(
                                              localizations.getLocalization(
                                                  "facebook_link"))) {
                                            await launch(
                                                localizations.getLocalization(
                                                    "facebook_link"));
                                          } else {
                                            throw 'Could not launch';
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: SvgPicture.asset(
                                            "assets/icons/facebook-icon.svg",
                                            height: 26,
                                            width: 26,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (await canLaunch(
                                              localizations.getLocalization(
                                                  "instagram_link"))) {
                                            await launch(
                                                localizations.getLocalization(
                                                    "instagram_link"));
                                          } else {
                                            throw 'Could not launch';
                                          }
                                        },
                                        child: Container(
                                          child: SvgPicture.asset(
                                            "assets/icons/instagram-icon.svg",
                                            height: 26,
                                            width: 26,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )))
              : Container(
                  width: 185,
                  child: Drawer(
                      child: Container(
                    color: HexColor.fromHex('#2f3c6e'),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: Image.asset(
                                'assets/icons/drawer-close-icon.png',
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 14, bottom: 10, top: 10),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.08,
                              child: ClipOval(
                                child: avatarUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: avatarUrl,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      )
                                    : Container(
                                        color: Colors.blue,
                                      ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset(
                                'assets/icons/courses-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations.getLocalization('user_courses'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CoursesScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/home-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations.getLocalization('homepage'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(WelcomeScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset(
                                'assets/icons/courses-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                              localizations
                                  .getLocalization('burger_menu_courses'),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: font_size, color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(CategoryDetailScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/book-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_books'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(BookScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset(
                                'assets/icons/bookmark-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_bookmark'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(BooksBookmark.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/donate-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_donate'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(DonateScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/qoute-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_quote'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(QuoteScreen.routeName);
                            },
                          ),
                          ListTile(
                            leading: Image.asset(
                                'assets/icons/about-us-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_about'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(AboutUs.routeName);
                            },
                          ),
                          /*ListTile(
                                  leading: Image.asset(
                                      'assets/icons/instagram-icon.png',
                                      height: icon_height,
                                      width: icon_width,
                                      fit: BoxFit.contain),
                                  title: Text('تغذية الانستغرام',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(InstagramFeed.routeName);
                                  },
                                ),*/
                          ListTile(
                            leading: Image.asset(
                                'assets/icons/settings-icon.png',
                                height: icon_height,
                                width: icon_width,
                                fit: BoxFit.contain),
                            title: Text(
                                localizations
                                    .getLocalization('burger_menu_setting'),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: font_size, color: Colors.white)),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(SettingScreen.routeName);
                            },
                          ),
                          Container(
                            child: ListTile(
                              leading: Image.asset('assets/icons/user-icon.png',
                                  height: icon_height,
                                  width: icon_width,
                                  fit: BoxFit.contain),
                              title: Text(
                                  localizations
                                      .getLocalization('burger_menu_profile'),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: font_size,
                                      color: Colors.white)),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushNamed(ProfileScreen.routeName);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/icons/logout-icon.png',
                                  height: icon_height,
                                  width: icon_width,
                                  fit: BoxFit.contain),
                              onTap: () {
                                showLogoutDialog(context, _block);
                              },
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 20, left: 16, top: 10),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    if (await canLaunch(localizations
                                        .getLocalization("youtube_link"))) {
                                      await launch(localizations
                                          .getLocalization("youtube_link"));
                                    } else {
                                      throw 'Could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: SvgPicture.asset(
                                      "assets/icons/youtube-icon.svg",
                                      height: 26,
                                      width: 26,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (await canLaunch(localizations
                                        .getLocalization("facebook_link"))) {
                                      await launch(localizations
                                          .getLocalization("facebook_link"));
                                    } else {
                                      throw 'Could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: SvgPicture.asset(
                                      "assets/icons/facebook-icon.svg",
                                      height: 26,
                                      width: 26,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (await canLaunch(localizations
                                        .getLocalization("instagram_link"))) {
                                      await launch(localizations
                                          .getLocalization("instagram_link"));
                                    } else {
                                      throw 'Could not launch';
                                    }
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/icons/instagram-icon.svg",
                                      height: 26,
                                      width: 26,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                );
        },
      ),
    );
  }

  showLogoutDialog(BuildContext context, ProfileBloc _bloc) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        localizations.getLocalization("cancel_button"),
        textScaleFactor: 1.0,
        style: TextStyle(color: mainColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        localizations.getLocalization("logout"),
        textScaleFactor: 1.0,
        style: TextStyle(color: mainColor),
      ),
      onPressed: () {
        _bloc.add(LogoutProfileEvent());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(localizations.getLocalization("logout"),
          textScaleFactor: 1.0,
          style: TextStyle(color: Colors.black, fontSize: 20.0)),
      content: Text(
        localizations.getLocalization("logout_message"),
        textScaleFactor: 1.0,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
