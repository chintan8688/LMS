import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masterstudy_app/data/models/quote.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/quote/bloc.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuoteScreen extends StatelessWidget {
  static const String routeName = 'quoteScreen';

  QuoteBloc _bloc;

  QuoteScreen(this._bloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteBloc>(
        create: (c) => _bloc, child: QuoteStateWidget());
  }
}

class QuoteStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuoteWidgetState();
  }
}

class QuoteWidgetState extends State<QuoteStateWidget> {
  WebViewController _descriptionWebViewController;

  QuoteBloc _bloc;
  QuoteBean bean;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuoteBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return BlocBuilder<QuoteBloc, QuoteState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialQuoteState) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadedQuoteState) {
            bean = state.bean;
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
              body: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/bg.png"),
                          repeat: ImageRepeat.repeat),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            'assets/icons/qoute-blue-icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            bean.title,
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#2f3c6e')),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          margin: EdgeInsets.only(top: 25, bottom: 10),
                          child: Text(
                            bean.quote,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.amiri(
                              fontSize: 30,
                              color: HexColor.fromHex('#2f3c6e'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ));
        });
  }
}
