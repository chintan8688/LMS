import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_bloc.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_event.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_state.dart';
import 'package:masterstudy_app/ui/screen/login/login_Screen.dart';
import 'package:masterstudy_app/ui/screen/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreenArgs {
  final OptionsBean optionsBean;

  final List<CountryDropdown> countries;

  SignUpScreenArgs(this.optionsBean, this.countries);
}

@provide
class SignUpScreen extends StatelessWidget {
  final AuthBloc _bloc;
  final SharedPreferences _sharedPreferences;
  static const routeName = "signUpScreen";

  SignUpScreen(this._bloc, this._sharedPreferences);

  @override
  Widget build(BuildContext context) {
    final SignUpScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
        child: SignUpScreenWidget(
            args.optionsBean, args.countries, this._sharedPreferences),
        create: (context) => _bloc);
  }
}

class SignUpScreenWidget extends StatefulWidget {
  final OptionsBean optionsBean;

  final SharedPreferences _sharedPreferences;

  final List<CountryDropdown> countries;

  const SignUpScreenWidget(
      this.optionsBean, this.countries, this._sharedPreferences)
      : super();

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenWidgetState();
  }
}

class SignUpScreenWidgetState extends State<SignUpScreenWidget> {
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
          child: _SignUpPage(
              widget.optionsBean, widget.countries, widget._sharedPreferences),
        ));
  }
}

class _SignUpPage extends StatefulWidget {
  final OptionsBean optionsBean;

  final List<CountryDropdown> countries;

  final SharedPreferences _sharedPreferences;

  const _SignUpPage(this.optionsBean, this.countries, this._sharedPreferences)
      : super();

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<_SignUpPage> {
  AuthBloc _bloc;
  final _formKey = GlobalKey<FormState>();

  String country;
  DateTime selectedDate = null;

  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _phoneCodeController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //country = widget.countries[0].id.toString();

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
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 20.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _loginController,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  localizations.getLocalization("full_name"),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 20.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
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
                        child: TextFormField(
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
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 48, right: 48),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              value: country,
                              isExpanded: true,
                              hint: Text(
                                'حدد الدولة',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              iconSize: 24,
                              style: TextStyle(color: Colors.black),
                              items:
                                  widget.countries.map((CountryDropdown item) {
                                String emoji =
                                    item.emoji != null ? item.emoji : "";
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    emoji + " " + item.name,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  value: item.id.toString(),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  country = newValue;
                                  changePhoneCode(country);
                                });
                              },
                            )),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 40) /
                                        100,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 48.0, right: 5),
                                  height: 45,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[100]),
                                  child: TextFormField(
                                    enabled: false,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    controller: _phoneCodeController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '+966',
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15)),
                                  ),
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 60) /
                                        100,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 48.0),
                                  height: 45,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[100]),
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: localizations
                                            .getLocalization("phone"),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15)),
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 48.0,
                          right: 48.0,
                        ),
                        child: Text(
                          localizations.getLocalization('birthdate'),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 48.0, right: 48.0, top: 10.0),
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 13),
                              child: Text(
                                selectedDate == null
                                    ? localizations.getLocalization("birthdate")
                                    : "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                  color: ((selectedDate == null)
                                      ? Colors.grey[600]
                                      : Colors.black),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            onTap: () => _selectDate(context),
                          )),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 40.0),
                        height: 35,
                        width: 160,
                        decoration: BoxDecoration(color: Colors.white),
                        child: new MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minWidth: double.infinity,
                          color: mainColor,
                          onPressed: register,
                          child: setUpButtonChild(enableInputs),
                          textColor: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: GestureDetector(
                                child: Container(
                                  child: Text(
                                    localizations
                                        .getLocalization('login_label_text'),
                                    style: TextStyle(color: mainColor),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushNamed(
                                      LoginScreen.routeName,
                                      arguments:
                                          LoginScreenArgs(widget.optionsBean))
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'هل لديك حساب؟',
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //     padding: EdgeInsets.only(top: 20),
                      //     child: Text(
                      //       'أو تسجيل الدخول باستخدام:',
                      //       textDirection: TextDirection.rtl,
                      //     )),
                      // Container(
                      //   padding: EdgeInsets.only(top: 20),
                      //   margin: EdgeInsets.only(bottom: 40),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Container(
                      //           child: GestureDetector(
                      //         child: Image.asset(
                      //           'assets/icons/google-icon.png',
                      //           height: 25,
                      //           width: 25,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         onTap: googleSignIn,
                      //       )),
                      //       Container(
                      //           margin: EdgeInsets.only(left: 25),
                      //           child: GestureDetector(
                      //             child: Image.asset(
                      //               'assets/icons/facebook-icon.png',
                      //               height: 25,
                      //               width: 25,
                      //               fit: BoxFit.contain,
                      //             ),
                      //             onTap: googleSignIn,
                      //           ))
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )))
          ],
        )));
      },
    );
  }

  changePhoneCode(String id) {
    for (var obj in widget.countries) {
      if (obj.id == int.parse(id)) {
        _phoneCodeController.text = obj.phone_code;
      }
    }
  }

  void register() {
    if (_loginController.text == '') {
      showDialogError(
          context, localizations.getLocalization("name_empty_error_text"));
    } else if (_emailController.text == '') {
      showDialogError(
          context, localizations.getLocalization("email_empty_error_text"));
    } else if (!(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text))) {
      showDialogError(
          context, localizations.getLocalization('email_invalid_error_text'));
    } else if (_passwordController.text == '') {
      showDialogError(
          context, localizations.getLocalization("password_empty_error_text"));
    } else if (_phoneController.text == '') {
      showDialogError(
          context, localizations.getLocalization("phone_empty_error_text"));
    } else if (country == '' || country == null) {
      showDialogError(context, 'يرجى تحديد الدولة');
    } else if (selectedDate == null) {
      showDialogError(
          context, localizations.getLocalization('birthdate_empty_error_text'));
    } else {
      /* String phoneNumber =
          _phoneCodeController.text.trim() + _phoneController.text.trim();*/

      String token = widget._sharedPreferences.getString('device_token');

      _bloc.add(RegisterEvent(
          _loginController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _phoneController.text.trim(),
          _phoneCodeController.text.trim(),
          country,
          selectedDate,
          token));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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

  Widget setUpButtonChild(enable) {
    if (enable == true) {
      return new Text(
        localizations.getLocalization("registration_button"),
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
}
