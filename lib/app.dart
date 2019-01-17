import 'package:flutter/material.dart';
import 'supplemental/cut_corners_border.dart';

import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'category_menu_page.dart';

import 'backdrop.dart';
import 'model/product.dart';

class ShrineApp extends StatefulWidget {
  @override
  _ShrineAppState createState() {
    return new _ShrineAppState();
  }

  static ThemeData _buildKShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: kShrinePink100,
      accentColor: kShrineBrown900,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kShrinePink100,
        textTheme: ButtonTextTheme.normal,
      ),
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
        color: kShrineBrown900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(),
      ),
    );
  }

  static TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
          ),
          title: base.title.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900,
        );
  }
}

class _ShrineAppState extends State<ShrineApp> {
  final ThemeData _kShrineTheme = ShrineApp._buildKShrineTheme();

  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: Backdrop(
        currentCategory: _currentCategory,
        frontLayer: HomePage(
          category: _currentCategory,
        ),
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kShrineTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
