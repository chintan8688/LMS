import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/settings.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/setting/bloc.dart';
import 'package:masterstudy_app/ui/bloc/setting/setting_bloc.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = 'settingScreen';

  final SettingBloc bloc;

  SettingScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
        create: (c) => bloc, child: _SettingWidget());
  }
}

class _SettingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreenWidgetState();
  }
}

class _SettingScreenWidgetState extends State<_SettingWidget> {
  int isNotification;

  SettingBloc _bloc;

  SettingsBean setting;

  bool isStart = true;

  TextEditingController _bug = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SettingBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return BlocBuilder<SettingBloc, SettingState>(
      bloc: _bloc,
      builder: (context, state) {
        if (isStart == true) {
          if (state is IntialSettingState) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is LoadedSettingState) {
            setting = state.bean;
            isNotification = setting.isNotification;
          }

          isStart = false;
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
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      child: Text(
                        'الأعدادات',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: HexColor.fromHex('#2f3c6e'),
                            fontSize: 42,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SwitchListTile(
                          activeColor: mainColor,
                          title: Text(
                            'أشعارات فورية',
                            textDirection: TextDirection.rtl,
                          ),
                          value: isNotification == 0 ? false : true,
                          onChanged: (bool value) {
                            setState(() {
                              isNotification = value == true ? 1 : 0;
                              _bloc.add(SetSettingEvent(isNotification));
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Theme(
                            data: theme,
                            child: ExpansionTile(
                              title: Text(
                                'الإبلاغ عن مشكلة',
                                textDirection: TextDirection.rtl,
                              ),
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 150,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70) /
                                              100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200]),
                                          child: TextFormField(
                                            controller: _bug,
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            maxLines: 20,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'أكتب هنا',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15)),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(top: 8),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            minWidth: 50,
                                            height: 30,
                                            child: Text('أرسال'),
                                            onPressed: () async {
                                              _bloc
                                                  .add(SendBugEvent(_bug.text));
                                              await showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      SuccessDialog());
                                            },
                                            color: mainColor,
                                            textColor: Colors.white,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width * 70) / 100,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: theme,
                          child: ExpansionTile(
                            title: Text(
                              'أسئلـة شائعة',
                              textDirection: TextDirection.rtl,
                            ),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                30) /
                                            100,
                                    width: (MediaQuery.of(context).size.width *
                                            70) /
                                        100,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: setting.faqs.length,
                                        itemBuilder: (context, index) {
                                          var item = setting.faqs[index];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200]),
                                                margin: EdgeInsets.only(top: 3),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: ExpansionTile(
                                                    title: Text(
                                                      item.title,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.right,
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        color: HexColor.fromHex(
                                                            "#273044"),
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        child: Text(
                                                          item.contetnt,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.right,
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              color: HexColor
                                                                  .fromHex(
                                                                      '#273044')),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        })),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'تم تقديم الطلب',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 22),
          ),
          Container(
              height: 30,
              width: 100,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'حسنا',
                  textDirection: TextDirection.rtl,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: mainColor,
                textColor: Colors.white,
              ))
        ],
      ),
    ));
  }
}
