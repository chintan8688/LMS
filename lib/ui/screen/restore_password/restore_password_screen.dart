import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/restore_password/bloc.dart';

import '../../../main.dart';

class RestorePasswordScreen extends StatelessWidget {
  static const routeName = "restorePasswordScreen";
  final RestorePasswordBloc bloc;

  const RestorePasswordScreen(this.bloc) : super();

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
      body: BlocProvider<RestorePasswordBloc>(
          create: (context) => bloc, child: _RestorePasswordWidget()),
    );
  }
}

class _RestorePasswordWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestorePasswordWidgetState();
  }
}

class _RestorePasswordWidgetState extends State<_RestorePasswordWidget> {
  RestorePasswordBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<RestorePasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessRestorePasswordState)
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                localizations.getLocalization("restore_password_sent_text")),
            backgroundColor: Colors.green,
          ));
        if( state is ErrorRestorePasswordState){
          showDialogError(context, state.error);
        }
      },
      child: BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
        bloc: _bloc,
        builder: (context, state) {
          return _buildForm(state);
        },
      ),
    );
  }

  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _buildForm(state) {
    var enableInputs = !(state is LoadingRestorePasswordState);
    return SingleChildScrollView(
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
        Container(
          margin: const EdgeInsets.only(left: 48.0, right: 48.0, top: 20.0),
          height: 45,
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: localizations.getLocalization('email_label_text'),
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40.0),
          height: 35,
          width: 200,
          decoration: BoxDecoration(color: Colors.white),
          child: new MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minWidth: double.infinity,
            color: mainColor,
            child: setUpButtonChild(enableInputs),
            onPressed: register,
            textColor: Colors.white,
          ),
        ),
      ],
    ));
  }

  void register() {
    if (_emailController.text == '') {
      print('==: email not valid');
      showDialogError(
          context, localizations.getLocalization("email_empty_error_text"));
    } else {
      _bloc.add(SendRestorePasswordEvent(_emailController.text));
    }
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
                },
              ),
            ],
          );
        });
  }

  Widget setUpButtonChild(enable) {
    if (enable == true) {
      return new Text(
        localizations.getLocalization("restore_password_button"),
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

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return localizations.getLocalization("email_empty_error_text");
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return localizations.getLocalization("email_invalid_error_text");
  }
}
