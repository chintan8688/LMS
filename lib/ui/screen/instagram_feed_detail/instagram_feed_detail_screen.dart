import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/instagram_feed/bloc.dart';
import 'package:masterstudy_app/ui/widgets/drawer.dart';
import 'package:dio/dio.dart';

class FeedArgs {
  final String url;

  FeedArgs(this.url);
}

class FeedDetailScreen extends StatelessWidget {
  static const String routeName = 'feedDetail';

  @override
  Widget build(BuildContext context) {
    final FeedArgs args = ModalRoute.of(context).settings.arguments;
    return FeedDetailState(args.url);
  }
}

class FeedDetailState extends StatefulWidget {
  final String url;

  FeedDetailState(this.url);

  @override
  State<StatefulWidget> createState() {
    return FeedDetailWidgetState();
  }
}

class FeedDetailWidgetState extends State<FeedDetailState> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: GestureDetector(
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.url,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
