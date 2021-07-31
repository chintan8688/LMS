import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/ui/bloc/splash/bloc.dart';
import 'package:masterstudy_app/ui/screen/rootwelcome/root_welcome_screen.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';

@provide
class SplashScreen extends StatelessWidget {
  static const String routeName = "splashScreen";
  SplashBloc bloc;

  SplashScreen(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => bloc,
        child: SplashWidget(),
      ),
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashWidgetState();
  }
}

class SplashWidgetState extends State<SplashWidget> {
  List<CountryDropdown> countries;

  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(CheckAuthSplashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (BuildContext context, SplashState state) {
        return Center(child: _buildLogoBlock(state));
      },
    );
  }

  _buildLogoBlock(state) {
    if (state is InitialSplashState)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (state is CloseSplash) {
      countries = state.countries;

      if (state.isSigned) {
        if (state.appSettings != null) {
          openMainPage(state.appSettings.options, countries);
        } else {
          openMainPage(null, countries);
        }
      } else {
        if (state.appSettings != null) {
          openAuthPage(state.appSettings.options, countries);
        } else {
          print(state.appSettings);
          openAuthPage(null, countries);
        }
      }
      /* String imgUrl = "";
      String postsCount = "";
      if (state.appSettings != null) {
        imgUrl = (state.appSettings.options.logo == null)
            ? ""
            : state.appSettings.options.logo;
        if (state.appSettings.demo != null) {
          demoEnabled = state.appSettings.demo;
        }
        if (state.appSettings.addons != null)
          dripContentEnabled =
              state.appSettings.addons.sequential_drip_content != null &&
                  state.appSettings.addons.sequential_drip_content == "on";
        postsCount = state.appSettings.options.posts_count.toString();
      } */

      //appLogoUrl = imgUrl;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/logo.svg',
            fit: BoxFit.contain,
          ),
        ],
      );
    }
    if (state is ErrorSplashState) {
      return LoadingErrorWidget(() {
        BlocProvider.of<SplashBloc>(context).add(CheckAuthSplashEvent());
      });
    }
  }

  void openAuthPage(OptionsBean optionsBean, List<CountryDropdown> country) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacementNamed(RootWelcomeScreen.routeName,
            arguments: RootWelcomeArgs(optionsBean, country, false));
      });
    });
  }

  void openMainPage(OptionsBean optionsBean, List<CountryDropdown> country) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacementNamed(RootWelcomeScreen.routeName,
            arguments: RootWelcomeArgs(optionsBean, country, true));
      });
    });
  }
}
