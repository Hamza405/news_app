import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(listener: (context,state){},builder: (context,state){
      return NewsCubit.get(context).sports.length>0?ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>buildArticalItem(NewsCubit.get(context).sports[index],context), separatorBuilder: (context,index)=>Divider(), itemCount: 10):Center(child:CircularProgressIndicator());
    } );
  }
}