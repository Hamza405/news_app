import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(listener: (context,state){},builder: (context,state){
      return state is! NewsLoadingState?ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>buildArticalItem(NewsCubit.get(context).business[index],context), separatorBuilder: (context,index)=>Divider(), itemCount: 10):Center(child:CircularProgressIndicator());
    } );
  }
}