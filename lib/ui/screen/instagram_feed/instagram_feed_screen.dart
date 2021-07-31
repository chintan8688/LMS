import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/instagram_feed/bloc.dart';
import 'package:masterstudy_app/ui/screen/instagram_feed_detail/instagram_feed_detail_screen.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:dio/dio.dart';

class InstagramFeed extends StatelessWidget {
  static const String routeName = 'instagramFeedScreen';

  FeedBlock _block;

  InstagramFeed(this._block) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBlock>(
        create: (c) => _block, child: _FeedScreenWidget());
  }
}

class _FeedScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InstagramFeedWidgetState();
  }
}

class InstagramFeedWidgetState extends State<_FeedScreenWidget> {
  FeedBlock _block;

  InstagramFeedBean instaFeeds;
  Account account;

  @override
  void initState() {
    super.initState();
    _block = BlocProvider.of<FeedBlock>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return BlocBuilder<FeedBlock, FeedState>(
        bloc: _block,
        builder: (context, state) {
          if (state is InitialFeedState) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadedFeedState) {
            instaFeeds = state.feeds;
            account = state.account;
          }
          return Scaffold(
            key: _key,
            drawer: DrawerScreen(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: new AppBar(
                leading: IconButton(
                  icon: Image.asset(
                    'assets/icons/drawer-icon.png',
                    fit: BoxFit.contain,
                  ),
                  onPressed: () {
                    _key.currentState.openDrawer();
                  },
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: HexColor.fromHex('#f5f5f5'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            account.login,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 22,
                                color: HexColor.fromHex('#2f3c6e')),
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(account.avatar_url),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                      itemCount: instaFeeds.data.length,
                      itemBuilder: (context, index) {
                        var item = instaFeeds.data[index];
                        var paddingBottom = 0.0;
                        if (index == instaFeeds.data.length - 1)
                          paddingBottom = 16.0;
                        return Padding(
                          padding: EdgeInsets.only(bottom: paddingBottom),
                          child: buildFeeds(item, context),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  buildFeeds(DataBean bean, BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: CachedNetworkImage(
            imageUrl: bean.url,
          ),
          /*onTap: () async {
            await showDialog(
                context: context, builder: (_) => ImageDialog(bean.url));
          },*/
        ));
  }
}

class ImageDialog extends StatelessWidget {
  String url;

  ImageDialog(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.fill)),
            ),
          ),
          /*Positioned(
            right: 32,
            top: 160,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: mainColor,
                  child: Icon(Icons.close, color: HexColor.fromHex('#2f3c6e')),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
