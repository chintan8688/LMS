import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_bloc.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_event.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_state.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/home/home_screen.dart';
import 'package:masterstudy_app/ui/screen/main/main_screen.dart';
import 'package:masterstudy_app/ui/screen/restore_password/restore_password_screen.dart';
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenArgs {
  final OptionsBean optionsBean;

  LoginScreenArgs(this.optionsBean);
}

class LoginScreen extends StatelessWidget {
  final AuthBloc _bloc;
  final SharedPreferences _sharedPreferences;
  static const routeName = 'loginScreen';

  LoginScreen(this._bloc, this._sharedPreferences);

  @override
  Widget build(BuildContext context) {
    final LoginScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
        child: LoginScreenWidget(args.optionsBean, this._sharedPreferences),
        create: (context) => _bloc);
  }
}

class LoginScreenWidget extends StatefulWidget {
  final OptionsBean optionsBean;
  final SharedPreferences _sharedPreferences;

  const LoginScreenWidget(this.optionsBean, this._sharedPreferences) : super();

  @override
  State<StatefulWidget> createState() {
    return LoginScreenWidgetState();
  }
}

class LoginScreenWidgetState extends State<LoginScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0), // here th
          child: new AppBar(
            brightness: Brightness.light,
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
          child:
              _LoginScreenPage(widget.optionsBean, widget._sharedPreferences),
        ));
  }
}

class _LoginScreenPage extends StatefulWidget {
  final OptionsBean optionsBean;
  final SharedPreferences _sharedPreferences;

  const _LoginScreenPage(this.optionsBean, this._sharedPreferences) : super();

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<_LoginScreenPage> {
  AuthBloc _bloc;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        var enableInputs = !(state is LoadingAuthState);
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

        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'أهــلاً بـك!',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 45,
                        color: HexColor.fromHex('#2f3c6e'),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'تسجيل الدخول',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 26, color: Colors.grey[150]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 48.0, right: 48.0, top: 20.0),
                          height: 45,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: TextField(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: _emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: localizations
                                    .getLocalization("email_label_text"),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 48.0, right: 48.0, top: 20.0),
                          height: 45,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: TextField(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: localizations
                                    .getLocalization("password_label_text"),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15)),
                          ),
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(right: 35, top: 5.0),
                            height: 50,
                            child: FlatButton(
                              child: Text(
                                'هل نسيت كلمة المرور؟',
                                style: TextStyle(color: mainColor),
                                textDirection: TextDirection.rtl,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RestorePasswordScreen.routeName);
                              },
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          height: 35,
                          width: 160,
                          decoration: BoxDecoration(color: Colors.white),
                          child: new MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            minWidth: double.infinity,
                            color: mainColor,
                            child: setUpButtonChild(enableInputs),
                            onPressed: auth,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  style: TextStyle(color: mainColor),
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

  void auth() {
    if (_emailController.text == '') {
      showDialogError(
          context, localizations.getLocalization("email_empty_error_text"));
    } else if (_passwordController.text == '') {
      showDialogError(
          context, localizations.getLocalization("password_empty_error_text"));
    } else {
      _bloc.add(LoginEvent(_emailController.text, _passwordController.text,
          widget._sharedPreferences.getString('device_token')));
    }
  }
}

Widget setUpButtonChild(enable) {
  if (enable == true) {
    return new Text(
      localizations.getLocalization("auth_sign_in_tab"),
      textScaleFactor: 1.0,
    );
  } else {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
