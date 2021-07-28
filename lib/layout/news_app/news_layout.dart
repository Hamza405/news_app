import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/modules/search/search.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';
import 'package:todo_sqflite/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit =  NewsCubit.get(context);
        // cubit.getBusiness();
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon: Icon(Icons.search,color: Colors.amber[400],)),
              IconButton(onPressed: (){
                cubit.changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined,color: Colors.amber[400],))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomNavItem,
          ),
          body: cubit.screens[cubit.currentIndex],
          
        );
      },
    );
  }
}
