import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/text_lesson/bloc.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_screen.dart';
import 'package:masterstudy_app/ui/screen/final/final_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_audio/lesson_audio_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_stream/lesson_stream_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/questions/questions_screen.dart';
import 'package:masterstudy_app/ui/screen/quiz_lesson/quiz_lesson_screen.dart';
import 'package:masterstudy_app/ui/screen/user_course_locked/user_course_locked_screen.dart';
import 'package:masterstudy_app/ui/screen/video_screen/video_screen.dart';
import 'package:masterstudy_app/ui/widgets/warning_lessong_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../main.dart';

class TextLessonScreenArgs {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;
  final bool hasPreview;
  final bool trial;

  TextLessonScreenArgs(this.courseId, this.lessonId, this.authorAva,
      this.authorName, this.hasPreview, this.trial);
}

class TextLessonScreen extends StatelessWidget {
  static const routeName = "textLessonScreen";
  final TextLessonBloc bloc;

  const TextLessonScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    TextLessonScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<TextLessonBloc>(
        create: (context) => bloc,
        child: TextLessonWidget(args.courseId, args.lessonId, args.authorAva,
            args.authorName, args.hasPreview, args.trial));
  }
}

class TextLessonWidget extends StatefulWidget {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;
  final bool hasPreview;
  final bool trial;

  const TextLessonWidget(this.courseId, this.lessonId, this.authorAva,
      this.authorName, this.hasPreview, this.trial)
      : super();

  @override
  State<StatefulWidget> createState() {
    return TextLessonWidgetState();
  }
}

class TextLessonWidgetState extends State<TextLessonWidget> {
  TextLessonBloc _bloc;
  bool completed = false;

  VideoPlayerController _controller;
  YoutubePlayerController _youtubePlayerController;

  VoidCallback listener;

  bool video = true;
  bool videoPlayed = false;
  bool videoLoaded = false;

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  bool isPlaying = false;
  String audioUrl;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TextLessonBloc>(context)
      ..add(FetchEvent(widget.courseId, widget.lessonId));
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CacheWarningLessonState) {
          showDialog(
              context: context, builder: (context) => WarningLessonDialog());
        }
      },
      child: BlocBuilder<TextLessonBloc, TextLessonState>(
        bloc: _bloc,
        builder: (BuildContext context, TextLessonState state) {
          return Scaffold(
            backgroundColor: HexColor.fromHex("#151A25"),
            appBar: AppBar(
              backgroundColor: HexColor.fromHex("#273044"),
              title: _buildTitle(state),
            ),
            body: SingleChildScrollView(
              child: _buildBody(state),
            ),
            bottomNavigationBar:
                (!widget.trial) ? null : _buildBottomNavigation(state),
          );
        },
      ),
    );
  }

  _buildTitle(TextLessonState state) {
    if (state is InitialTextLessonState) return Center();
    if (state is LoadedTextLessonState) {
      audioUrl = state.lessonResponse.audio_url;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  state.lessonResponse.section.number,
                  textScaleFactor: 1.0,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Flexible(
                  child: Text(
                    state.lessonResponse.section.label,
                    textScaleFactor: 1.0,
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*(widget.hasPreview)
              ? Center()
              : SizedBox(
                  width: 40,
                  height: 40,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: HexColor.fromHex("#3E4555"))),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        QuestionsScreen.routeName,
                        arguments: QuestionsScreenArgs(widget.lessonId, 1),
                      );
                    },
                    padding: EdgeInsets.all(0.0),
                    color: HexColor.fromHex("#3E4555"),
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          "assets/icons/question_icon.svg",
                          color: Colors.white,
                        )),
                  ),
                )*/
        ],
      );
    }
  }

  _buildBody(TextLessonState state) {
    if (state is InitialTextLessonState) return _buildLoading();
    if (state is LoadedTextLessonState) {
      audioUrl = state.lessonResponse.audio_url;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0, right: 7.0, left: 7.0),
            child: Html(
              data: state.lessonResponse.title,
              defaultTextStyle: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.w700,
                  color: HexColor.fromHex("#FFFFFF")),
            ),
          ),
          Visibility(
            visible: (state.lessonResponse.video != "" ? true : false),
            child: Padding(
                padding: EdgeInsets.only(
                    top: 15.0, right: 7.0, bottom: 10.0, left: 7.0),
                child: Text(
                  "Video ${state.lessonResponse.section.index}",
                  textScaleFactor: 1.0,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: HexColor.fromHex("#FFFFFF")),
                )),
          ),
          Visibility(
            visible: (state.lessonResponse.video != "" ? true : false),
            child: Container(
              height: 211.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 211.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(state.lessonResponse.video_poster),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 110,
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: Container(
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              // has the effect of softening the shadow
                              spreadRadius: -2,
                              // has the effect of extending the shadow
                              offset: Offset(
                                0,
                                // horizontal, move right 10
                                12.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: () async {
                            //_buildVideoPopup(state);
                            if (isPlaying) {
                              audioPlayer.pause();
                              setState(() {
                                isPlaying = false;
                              });
                            }
                            if (Platform.isIOS) {
                              _launchURL(state.lessonResponse.video);
                            } else {
                              Navigator.of(context).pushNamed(
                                VideoScreen.routeName,
                                arguments: VideoScreenArgs(
                                    state.lessonResponse.title,
                                    state.lessonResponse.video),
                              );
                            }
                          },
                          padding: EdgeInsets.all(0.0),
                          color: HexColor.fromHex("#D7143A"),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 0, right: 4.0),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  )),
                              Text(
                                localizations
                                    .getLocalization("play_video_button"),
                                textScaleFactor: 1.0,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (state.lessonResponse.audio_url != "" ? true : false),
            child: Padding(
                padding: EdgeInsets.only(
                    top: 15.0, right: 7.0, bottom: 10.0, left: 7.0),
                child: Text(
                  "Audio ${state.lessonResponse.section.index}",
                  textScaleFactor: 1.0,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: HexColor.fromHex("#FFFFFF")),
                )),
          ),
          Visibility(
            visible: (state.lessonResponse.audio_url != "" ? true : false),
            child: Container(
                padding: EdgeInsets.only(top: 10.0, right: 7.0, left: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Slider.adaptive(
                        activeColor: mainColor,
                        min: 0.0,
                        value: position.inSeconds.toDouble(),
                        max: duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            audioPlayer
                                .seek(new Duration(seconds: value.toInt()));
                          });
                        }),
                    Container(
                      child: InkWell(
                        onTap: () {
                          getAudio();
                        },
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 30,
                          color: HexColor.fromHex('#2f3c6e'),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          //_buildWebView(state)
          _buildWebContent(state.lessonResponse.content),
        ],
      );
    }
  }

  _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  /*WebViewController _webViewController;
  bool showLoadingWebview = true;

  _buildWebView(LoadedTextLessonState state) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(state.lessonResponse.content))}',
      onPageFinished: (some) async {},
      onWebViewCreated: (controller) async {
        controller.clearCache();
        this._webViewController = controller;
      },
    );
  }*/

  WebViewController _descriptionWebViewController;
  double descriptionHeight;

  _buildWebContent(String content) {
    /*if (Platform.isAndroid &&
        (androidInfo.version.sdkInt == 28 ||
            androidInfo.version.sdkInt == 29)) {
      return Html(
          data: content,
          useRichText: true,
          defaultTextStyle: TextStyle(color: HexColor.fromHex("#FFFFFF")));
    }*/

    return Html(
        data: content,
        useRichText: true,
        defaultTextStyle: TextStyle(color: HexColor.fromHex("#FFFFFF")));

    double webContainerHeight;
    if (descriptionHeight != null) {
      webContainerHeight = descriptionHeight;
    } else {
      webContainerHeight = 160;
    }
    return Padding(
      padding: EdgeInsets.only(right: 7.0, left: 7.0),
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(content))}',
        onPageFinished: (some) async {
          double height = double.parse(await _descriptionWebViewController
              .evaluateJavascript("document.documentElement.scrollHeight;"));
          setState(() {
            descriptionHeight = height;
          });
        },
        onWebViewCreated: (controller) async {
          controller.clearCache();
          this._descriptionWebViewController = controller;
        },
      ),
    );
  }

  _buildBottomNavigation(TextLessonState state) {
    if (state is InitialTextLessonState)
      return Center(child: CircularProgressIndicator());

    if (state is LoadedTextLessonState) {
      return Container(
        decoration:
            BoxDecoration(color: HexColor.fromHex("#FFFFFF"), boxShadow: [
          BoxShadow(
              color: HexColor.fromHex("#000000").withOpacity(.1),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 2)
        ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                  width: 35,
                  height: 35,
                  child: (state.lessonResponse.prev_lesson != "")
                      ? FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: mainColor)),
                          onPressed: () {
                            switch (state.lessonResponse.prev_lesson_type) {
                              case "video":
                                Navigator.of(context).pushReplacementNamed(
                                  LessonVideoScreen.routeName,
                                  arguments: LessonVideoScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName,
                                      widget.hasPreview,
                                      widget.trial),
                                );
                                break;
                              case "audio":
                                Navigator.of(context).pushReplacementNamed(
                                  LessonAudioScreen.routeName,
                                  arguments: LessonAudioScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName,
                                      widget.hasPreview,
                                      widget.trial),
                                );
                                break;
                              case "quiz":
                                Navigator.of(context).pushReplacementNamed(
                                  QuizLessonScreen.routeName,
                                  arguments: QuizLessonScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName),
                                );
                                break;
                              case "assignment":
                                Navigator.of(context).pushReplacementNamed(
                                  AssignmentScreen.routeName,
                                  arguments: AssignmentScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName),
                                );
                                break;
                              case "stream":
                                Navigator.of(context).pushReplacementNamed(
                                  LessonStreamScreen.routeName,
                                  arguments: LessonStreamScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName),
                                );
                                break;
                              default:
                                Navigator.of(context).pushReplacementNamed(
                                  TextLessonScreen.routeName,
                                  arguments: TextLessonScreenArgs(
                                      widget.courseId,
                                      int.tryParse(
                                          state.lessonResponse.prev_lesson),
                                      widget.authorAva,
                                      widget.authorName,
                                      widget.hasPreview,
                                      widget.trial),
                                );
                            }
                          },
                          padding: EdgeInsets.all(0.0),
                          color: mainColor,
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        )
                      : Center()),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                      height: 50,
                      color: mainColor,
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        if (state is LoadedTextLessonState &&
                            !state.lessonResponse.completed) {
                          _bloc.add(CompleteLessonEvent(
                              widget.courseId, widget.lessonId));
                          setState(() {
                            completed = true;
                          });
                        } else if (state.lessonResponse.completed &&
                            !state.lessonResponse.next_lesson_available) {
                          Navigator.of(context).pushNamed(
                            FinalScreen.routeName,
                            arguments: FinalScreenArgs(widget.courseId),
                          );
                        }
                      },
                      child: _buildButtonChild(state)),
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: mainColor)),
                  onPressed: () {
                    if (state.lessonResponse.next_lesson != "") {
                      if (state.lessonResponse.next_lesson_available) {
                        switch (state.lessonResponse.next_lesson_type) {
                          case "video":
                            Navigator.of(context).pushReplacementNamed(
                              LessonVideoScreen.routeName,
                              arguments: LessonVideoScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName,
                                  widget.hasPreview,
                                  widget.trial),
                            );
                            break;
                          case "audio":
                            Navigator.of(context).pushReplacementNamed(
                              LessonAudioScreen.routeName,
                              arguments: LessonAudioScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName,
                                  widget.hasPreview,
                                  widget.trial),
                            );
                            break;
                          case "quiz":
                            Navigator.of(context).pushReplacementNamed(
                              QuizLessonScreen.routeName,
                              arguments: QuizLessonScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName),
                            );
                            break;
                          case "assignment":
                            Navigator.of(context).pushReplacementNamed(
                              AssignmentScreen.routeName,
                              arguments: AssignmentScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName),
                            );
                            break;
                          case "stream":
                            Navigator.of(context).pushReplacementNamed(
                              LessonStreamScreen.routeName,
                              arguments: LessonStreamScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName),
                            );
                            break;
                          default:
                            Navigator.of(context).pushReplacementNamed(
                              TextLessonScreen.routeName,
                              arguments: TextLessonScreenArgs(
                                  widget.courseId,
                                  int.tryParse(
                                      state.lessonResponse.next_lesson),
                                  widget.authorAva,
                                  widget.authorName,
                                  widget.hasPreview,
                                  widget.trial),
                            );
                        }
                      } else {
                        /*Navigator.of(context).pushNamed(
                          UserCourseLockedScreen.routeName,
                          arguments:
                              UserCourseLockedScreenArgs(widget.courseId),
                        );*/
                      }
                    } else {
                      var future = Navigator.of(context).pushNamed(
                        FinalScreen.routeName,
                        arguments: FinalScreenArgs(widget.courseId),
                      );
                      future.then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  padding: EdgeInsets.all(0.0),
                  color: mainColor,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  _buildButtonChild(TextLessonState state) {
    if (state is InitialTextLessonState)
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    if (state is LoadedTextLessonState) {
      Widget icon;
      if (state.lessonResponse.completed || completed) {
        icon = Icon(
          Icons.check_circle,
          color: Colors.white,
        );
      } else {
        icon = Icon(Icons.panorama_fish_eye, color: Colors.white);
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              localizations.getLocalization("complete_lesson_button"),
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.0,
            ),
          )
        ],
      );
    }
  }

  getAudio() async {
    if (isPlaying) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else {
      var res = await audioPlayer.play(audioUrl);
      if (res == 1) {
        setState(() {
          isPlaying = true;
        });
      }
      audioPlayer.onDurationChanged.listen((Duration dd) {
        setState(() {
          duration = dd;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((Duration dd) {
        setState(() {
          position = dd;
        });
      });
      audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          isPlaying = false;
          duration = new Duration();
          position = new Duration();
        });
      });
    }
  }

  _launchURL(String url) async {
    await launch(url);
  }
}
