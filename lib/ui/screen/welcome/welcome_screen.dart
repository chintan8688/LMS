import 'package:flutter/material.dart';

import 'package:masterstudy_app/theme/theme.dart';

import 'package:masterstudy_app/ui/screen/books/books_screen.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/donation_screen/donation_screen.dart';
import 'package:masterstudy_app/ui/screen/quote_screen/quote_screen.dart';

import 'package:masterstudy_app/ui/widgets/drawer.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = 'welcomeScreen';
  double font_size;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    font_size = MediaQuery.of(context).size.height >= 600 ? 26 : 24;
    return Scaffold(
      key: _key,
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
      body: Container(
        color: HexColor.fromHex('#f5f5f5'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          //padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/book-blue-icon.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.2,
                                fit: BoxFit.contain,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Text(
                                  'الكتـب',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: font_size,
                                      color: HexColor.fromHex('#2f3c6e'),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                      onTap: () {
                        Navigator.of(context).pushNamed(BookScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        //padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/courses-blue-icon.png',
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.contain,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.005),
                              child: Text(
                                'الدورات',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: font_size,
                                    color: HexColor.fromHex('#2f3c6e'),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CategoryDetailScreen.routeName);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        //padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/qoute-blue-icon.png',
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.contain,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.005),
                              child: Text(
                                'دعاء اليوم',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: font_size,
                                    color: HexColor.fromHex('#2f3c6e'),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(QuoteScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        //padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/donate-blue-icon.png',
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.contain,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.005),
                              child: Text(
                                'تبـــــرع',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: font_size,
                                    color: HexColor.fromHex('#2f3c6e'),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(DonateScreen.routeName);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
