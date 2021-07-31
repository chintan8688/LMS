import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/about_us.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/about_us/about_us_bloc.dart';
import 'package:masterstudy_app/ui/bloc/about_us/about_us_event.dart';
import 'package:masterstudy_app/ui/bloc/about_us/about_us_state.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'aboutUsScreen';

  AboutUsBloc _bloc;

  AboutUs(this._bloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutUsBloc>(
        create: (c) => _bloc, child: AboutUsStateWidget());
  }
}

class AboutUsStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutUsWidgetState();
  }
}

class AboutUsWidgetState extends State<AboutUsStateWidget> {
  WebViewController _descriptionWebViewController;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AboutUsBloc _bloc;
  AboutUsBean about;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AboutUsBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutUsBloc, AboutUsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialAboutUsState) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadedAboutUsState) {
            about = state.bean;
          }
          return new Scaffold(
              key: _scaffoldKey,
              drawer: DrawerScreen(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: new AppBar(
                  leading: Transform.scale(
                    scale: 0.7,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/drawer-icon.svg',
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                  brightness: Brightness.dark,
                  actions: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 14, top: 8),
                        child: Row(
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
                            Text(
                              about.title,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ))
                  ],
                  elevation: 0,
                  backgroundColor: HexColor.fromHex('#2f3c6e'),
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: Opacity(
                  opacity: isLoaded ? 1 : 0,
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl:
                        'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(about.url))}',
                    onWebViewCreated: (controller) async {
                      controller.clearCache();
                      this._descriptionWebViewController = controller;
                    },
                    onPageFinished: (String url) {
                      setState(() {
                        isLoaded = true;
                      });
                    },
                  ),
                ),
              ));
        });
  }
}
