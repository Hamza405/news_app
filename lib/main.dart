import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';
import 'package:todo_sqflite/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cash_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool isDark =CashHelper.getData('isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  //https://github.com/abdullahmansss/naruto
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..changeAppMode(fromShared:isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            // themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.amber,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.amber[400]),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    elevation: 0.0,
                    color: Colors.white,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                iconTheme: IconThemeData(color: Colors.black38),
                textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.amber[400],
                    type: BottomNavigationBarType.fixed,
                    elevation: 30.0)),
            darkTheme: ThemeData(
                dividerColor: Colors.white,
                scaffoldBackgroundColor: HexColor('34495e'),
                primarySwatch: Colors.amber,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.amber[400]),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('34495e'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    elevation: 0.0,
                    color: HexColor('34495e'),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                iconTheme: IconThemeData(color: Colors.white),
                textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.amber[400],
                    type: BottomNavigationBarType.fixed,
                    elevation: 30.0,
                    backgroundColor: HexColor('34495e'),
                    unselectedItemColor: Colors.grey)),
            themeMode:NewsCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
