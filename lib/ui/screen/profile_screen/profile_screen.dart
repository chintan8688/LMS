import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/profile/bloc.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'profileScreen';
  ProfileBloc _bloc;

  ProfileScreen(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (c) => _bloc, child: _ProfileWidget());
  }
}

class _ProfileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileWidgetState();
  }
}

class _ProfileWidgetState extends State<_ProfileWidget> {
  File image = null;

  ProfileBloc _bloc;

  Account account;

  List<CountryDropdown> countries;

  String country;

  DateTime selectedDate = null;

  bool isStart = true;

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneCodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();
  TextEditingController _oPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProfileBloc>(context)..add(FetchProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _bloc,
      builder: (context, state) {
        if (isStart == true) {
          if (state is InitialProfileState) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is LoadedProfileState) {
            account = state.account;
            countries = state.countries;

            _fNameController.text = account.metabean.f_name;
            _lNameController.text = account.metabean.l_name;
            _emailController.text = account.email;
            _phoneCodeController.text = account.metabean.phoneCode == ''
                ? '+961'
                : account.metabean.phoneCode;
            _phoneController.text = account.metabean.phone;
            country = account.metabean.country == ''
                ? '121'
                : account.metabean.country;

            selectedDate = account.metabean.bDate == ''
                ? intl.DateFormat('yyyy-MM-dd').parse(DateTime.now().toString())
                : intl.DateFormat('yyyy-MM-dd').parse(account.metabean.bDate);

            isStart = false;
          }
        }

        if (state is SuccessUpdateState) {
          if (state.response['error'] != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                showUpdateDialogError(context,
                    state.response['error']['password'].toString(), "خطأ"));
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                showUpdateDialogError(
                    context, 'تم حفظ الملف الشخصي', "النجاح"));
          }
        }

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
            body: SingleChildScrollView(
              child: Container(
                  color: HexColor.fromHex('#f5f5f5'),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'الملف الشخصي',
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex('#2f3c6e')),
                        ),
                      ),
                      Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: mainColor,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                    child: image != null
                                        ? Image.file(
                                            image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(account.avatar_url)),
                              ),
                            ),
                            onTap: () {
                              _imgFromGallery();
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'تعديل الملف الشخصي',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _fNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  localizations.getLocalization("first_name"),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                          /*onChanged: (text) {
                            _nameController.text = text;
                          },*/
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _lNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  localizations.getLocalization("last_name"),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                          /*onChanged: (text) {
                            _nameController.text = text;
                          },*/
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          /*onChanged: (text) {
                            _emailController.text = text;
                          },*/
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: localizations
                                  .getLocalization("email_label_text"),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                          //width: (MediaQuery.of(context).size.width * 70) / 100,
                          margin: const EdgeInsets.only(
                              left: 48.0, right: 48.0, top: 10.0),
                          height: 45,
                          decoration: BoxDecoration(color: Colors.grey[200]),
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
                              items: countries.map((CountryDropdown item) {
                                String emoji =
                                    item.emoji != null ? item.emoji : "";
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    emoji + " " + item.name,
                                    textAlign: TextAlign.right,
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
                          padding: const EdgeInsets.only(top: 10.0),
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
                                      BoxDecoration(color: Colors.grey[200]),
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
                                      right: 48.0, left: 5),
                                  height: 45,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
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
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 48.0, right: 48.0, top: 10.0),
                          height: 45,
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 13),
                              child: Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                  color: ((selectedDate == null)
                                      ? Colors.grey[600]
                                      : Colors.black),
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            onTap: () => _selectDate(context),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'كلمة السر',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _oPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'كلمة المرور القديمة',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 15.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
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
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          controller: _cPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'تأكيد كلمة السـر',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minWidth: 50,
                          height: 30,
                          child: Text('حفـظ'),
                          onPressed: () {
                            _validateProfile();
                          },
                          color: mainColor,
                          textColor: Colors.white,
                        ),
                      ),
                      /*Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'تفاصيل بطاقة الائتمان',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          //controller: _emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'الاسم على البطاقة',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          //controller: _emailController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'رقم بطاقة الائتمان',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          //controller: _emailController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'تاريخ الانتهاء ',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        //width: (MediaQuery.of(context).size.width * 70) / 100,
                        margin: const EdgeInsets.only(
                            left: 48.0, right: 48.0, top: 10.0),
                        height: 45,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          //controller: _emailController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'CVC',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minWidth: 50,
                          height: 30,
                          child: Text('حفـظ'),
                          onPressed: () {},
                          color: mainColor,
                          textColor: Colors.white,
                        ),
                      ),*/
                    ],
                  )),
            ));
      },
    );
  }

  changePhoneCode(String id) {
    for (var obj in countries) {
      if (obj.id == int.parse(id)) {
        _phoneCodeController.text = "+" + obj.phone_code;
      }
    }
  }

  _imgFromGallery() async {
    File _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      image = _image;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _validateProfile() async {
    if (_fNameController.text == '') {
      showDialogError(
          context, localizations.getLocalization("name_empty_error_text"));
    } else if (_lNameController.text == '') {
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
    } else if (_phoneController.text == '') {
      showDialogError(
          context, localizations.getLocalization("phone_empty_error_text"));
    } else if (country == '' || country == null) {
      showDialogError(context, 'يرجى تحديد الدولة');
    } else if (selectedDate == null) {
      showDialogError(
          context, localizations.getLocalization('birthdate_empty_error_text'));
    } else if (_oPasswordController.text.trim() != "" &&
        _passwordController.text.trim() == "") {
      showDialogError(context, "الرجاء إدخال كلمة المرور الجديدة");
    } else if (_oPasswordController.text.trim() != "" &&
        _cPasswordController.text.trim() == "") {
      showDialogError(context, "الرجاء إدخال تأكيد كلمة المرور");
    } else if ((_passwordController.text.trim() != "" ||
            _cPasswordController.text.trim() != "") &&
        _oPasswordController.text.trim() == "") {
      showDialogError(context, "الرجاء إدخال كلمة المرور القديمة");
    } else if (_passwordController.text.trim() !=
        _cPasswordController.text.trim()) {
      showDialogError(context, 'كلمة المرور والتأكيد غير متطابقين');
    } else {
      _bloc.add(UpdateProfileEvent(
          _fNameController.text.trim(),
          _lNameController.text.trim(),
          _emailController.text.trim(),
          _phoneCodeController.text.trim(),
          _phoneController.text.trim(),
          country,
          selectedDate,
          _passwordController.text.trim(),
          _oPasswordController.text.trim(),
          image));
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
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void showUpdateDialogError(context, text, title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title,
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
                  Navigator.pop(context);
                  _bloc.add(CloseDialogEvent());
                },
              ),
            ],
          );
        });
  }
}
