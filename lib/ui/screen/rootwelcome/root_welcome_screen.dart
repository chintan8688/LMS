import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_bloc.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_event.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_state.dart';
import 'package:masterstudy_app/ui/screen/signup/signup_screen.dart';
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootWelcomeArgs {
  final OptionsBean optionsBean;

  final List<CountryDropdown> countries;

  final bool isSigned;

  RootWelcomeArgs(this.optionsBean, this.countries, this.isSigned);
}

class RootWelcomeScreen extends StatelessWidget {
  static const String routeName = 'rootWelcomeScreen';

  final AuthBloc _bloc;

  final SharedPreferences _sharedPreferences;

  RootWelcomeScreen(this._bloc, this._sharedPreferences);

  @override
  Widget build(BuildContext context) {
    final RootWelcomeArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      child: RootWelcomeScreenState(args.countries, args.optionsBean,
          args.isSigned, this._sharedPreferences),
      create: (context) => _bloc,
    );
  }
}

class RootWelcomeScreenState extends StatefulWidget {
  final OptionsBean optionsBean;

  final List<CountryDropdown> countries;

  final bool isSigned;

  final SharedPreferences _sharedPreferences;

  RootWelcomeScreenState(
      this.countries, this.optionsBean, this.isSigned, this._sharedPreferences)
      : super();

  @override
  State<StatefulWidget> createState() {
    return RootWelcomeScreenWidgetState();
  }
}

class RootWelcomeScreenWidgetState extends State<RootWelcomeScreenState> {
  AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AuthBloc>(context);
    if (widget.isSigned == true) {
      startTime();
    }
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is SuccessAuthState) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => Navigator.pushReplacementNamed(
                    context,
                    WelcomeScreen.routeName,
                  ));
        }
        if (state is ErrorAuthState) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => showDialogError(context, state.message));
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(110.0),
            child: new AppBar(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'أهــلاً بـك!',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: HexColor.fromHex('#2f3c6e'),
                        fontSize: 52,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Visibility(
                  visible: (!widget.isSigned),
                  child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                child: Text(
                              'تسجيل الدخول مع:',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: SignInButton(
                                Buttons.Facebook,
                                onPressed: () {
                                  fbLogin();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: SignInButton(
                                Buttons.GoogleDark,
                                onPressed: () {
                                  googleSignIn();
                                },
                              ),
                            ),
                            Visibility(
                              visible: Platform.isIOS,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: SignInButton(
                                  Buttons.AppleDark,
                                  onPressed: () {
                                    iosLogin();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: SignInButton(
                                Buttons.Email,
                                text: "Sign Up",
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      SignUpScreen.routeName,
                                      arguments: SignUpScreenArgs(
                                          widget.optionsBean,
                                          widget.countries));
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogError(context, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(localizations.getLocalization("error_dialog_title"),
                textScaleFactor: 1.0,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            content: Text(
              text,
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  localizations.getLocalization("ok_dialog_button"),
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _bloc.add(CloseDialogEvent());
                },
              ),
            ],
          );
        });
  }

  fbLogin() {
    _bloc.add(FbLoginEvent(
        widget._sharedPreferences.getString('device_token'), 'FB'));
  }

  googleSignIn() {
    _bloc.add(GoogleSignInEvent(
        widget._sharedPreferences.getString('device_token'), 'GOOGLE'));
  }

  iosLogin() {}
}
