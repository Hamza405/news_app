import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: defualtTextFormField(
                    text: 'Search here',
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'search must not be empty';
                      return null;
                    }),
              ),
              Expanded(
                  child: list.length==0? Center(child: Text('no things to search'),) :ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildArticalItem(
                          list[index], context),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 10))
            ],
          ),
        );
      },
    );
  }
}
