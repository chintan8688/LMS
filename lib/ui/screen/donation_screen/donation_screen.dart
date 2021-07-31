import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';

class DonateScreen extends StatefulWidget {
  static const String routeName = 'donateScreen';

  @override
  State<StatefulWidget> createState() {
    return DonateScreenWidgetState();
  }
}

class DonateScreenWidgetState extends State<DonateScreen> {
  int selectedRadio;
  TextEditingController amountController = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
  }

  @override
  Widget build(BuildContext context) {
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
        reverse: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 80,
                width: 80,
                child: Image.asset(
                  'assets/icons/donate-blue-icon.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  localizations.getLocalization("donation_title"),
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: HexColor.fromHex('#2f3c6e')),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width * 70) / 100,
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  localizations.getLocalization("donation_line1"),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 24,
                      color: HexColor.fromHex('#2f3c6e'),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: (MediaQuery.of(context).size.width * 65) / 100,
                  child: RadioListTile(
                    dense: true,
                    value: 1,
                    groupValue: selectedRadio,
                    title: Text(
                      'صدقة جارية',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: HexColor.fromHex('#2f3c6e'),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val;
                      });
                    },
                    activeColor: HexColor.fromHex('#2f3c6e'),
                  )),
              Container(
                  width: (MediaQuery.of(context).size.width * 65) / 100,
                  child: RadioListTile(
                    dense: true,
                    value: 2,
                    groupValue: selectedRadio,
                    title: Text(
                      'زكـــــاة',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: HexColor.fromHex('#2f3c6e'),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val;
                      });
                    },
                    activeColor: HexColor.fromHex('#2f3c6e'),
                  )),
              Container(
                width: (MediaQuery.of(context).size.width * 70) / 100,
                child: Divider(
                  color: Colors.grey,
                  height: 2,
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width * 70) / 100,
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  localizations.getLocalization("donation_line2"),
                  overflow: TextOverflow.clip,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: HexColor.fromHex('#2f3c6e')),
                ),
              ),
              Container(
                  width: (MediaQuery.of(context).size.width * 60) / 100,
                  height: 45,
                  margin: EdgeInsets.only(top: 15),
                  child: TextField(
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: HexColor.fromHex('#2f3c6e'),
                        size: 26,
                      ),
                      border: InputBorder.none,
                      hintText: 'اكتب هنا',
                    ),
                  )),
              Container(
                width: (MediaQuery.of(context).size.width * 70) / 100,
                child: Divider(
                  color: Colors.grey,
                  height: 2,
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(top: 20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minWidth: 50,
                  height: 30,
                  child: Text('تبــــرع الأن '),
                  onPressed: () {},
                  color: mainColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
