import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/modules/business/business_screen.dart';
import 'package:todo_sqflite/modules/science/science_screen.dart';
import 'package:todo_sqflite/modules/settings/settings_screen.dart';
import 'package:todo_sqflite/modules/sports/sports_screen.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';
import 'package:todo_sqflite/shared/network/local/cash_helper.dart';
import 'package:todo_sqflite/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  IconData fabIcon = Icons.edit;
  bool isButtonShetShow = false;
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData('/v2/top-headlines', {
      'country': 'eg',
      'category': 'business',
      'apiKey': '6b6f7b72a6064368aaad8113eae6e74a',
    }).then((value) {
      business = value.data['articles'];
      print(business.length);
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetBusinessErrorState(e.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsLoadingState());
    if (science.length == 0) {
      DioHelper.getData('/v2/top-headlines', {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6b6f7b72a6064368aaad8113eae6e74a',
      }).then((value) {
        science = value.data['articles'];
        print(business.length);
        emit(NewsGetScienceSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetScienceErrorState(e.toString()));
      });
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData('/v2/top-headlines', {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6b6f7b72a6064368aaad8113eae6e74a',
      }).then((value) {
        sports = value.data['articles'];
        print(business.length);
        emit(NewsGetSportsSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSportsErrorState(e.toString()));
      });
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsLoadingState());
    search = [];
    DioHelper.getData('/v2/everything', {
      'q': '$value',
      'apiKey': '6b6f7b72a6064368aaad8113eae6e74a',
    }).then((value) {
      search = value.data['articles'];
      print(business.length);
      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetSearchErrorState(e.toString()));
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CashHelper.putData('isDark', isDark)
          .then((v) => emit(AppChangeModeState()));
    }

    print('mode is dark = $isDark');
  }
}
