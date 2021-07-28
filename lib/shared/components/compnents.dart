import 'package:flutter/material.dart';
import 'package:todo_sqflite/modules/web%20view/web_view_screen.dart';

Widget defaultButton(
        {double? width = double.infinity,
        Color? background = Colors.blue,
        @required Function? function,
        @required String? text,
        double radius = 10.0,
        bool isUpperCase = true}) =>
    Container(
      height: 50.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defualtTextFormField(
        {@required TextEditingController? controller,
        @required TextInputType? type,
        Function(String)? onSumbit,
        Function()? onTap,
        ValueChanged<String>? onChange,
        FormFieldValidator<String?>? validator,
        @required String? text,
        IconData? prefix,
        IconData? suffix,
        bool isClickable = true,
        bool isPassowrd=false,
        Function()? suffixPress}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassowrd,
      keyboardType: type,
      onFieldSubmitted: onSumbit,
      onChanged: onChange,
      validator: validator,
      enabled: isClickable,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffix: suffix!=null?IconButton(icon:Icon(suffix),onPressed: suffixPress,):null,
        border: OutlineInputBorder(),
      ),
    );

// Widget buildTasksItem(Map model,context)=>Dismissible(
//   key: Key(model['id'].toString()),
//   child:   Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
          
//           children: [
//             CircleAvatar(
//               radius: 45,
//               child:Text(model['time'])
//             ),
//             SizedBox(width: 20,),
//             Expanded(
//                         child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(model['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                   Text(model['date'],style: TextStyle(color: Colors.grey,fontSize: 20)),
//                 ],
//               ),
//             ),
//              SizedBox(width: 20,),
//              IconButton(onPressed: (){
//                AppCubit.get(context).updateData(status: 'done', id: model['id']);
//              }, icon: Icon(Icons.check,color: Colors.blue,)),
//              IconButton(onPressed: (){
//                AppCubit.get(context).updateData(status: 'archive', id: model['id']);
//              }, icon: Icon(Icons.archive_rounded,color:Colors.black26))
//           ],
//         ),
//       ),
//       onDismissed: (d){
//         AppCubit.get(context).deleteFromDataBase(model['id']);
//       },
// );

Widget buildArticalItem(artical,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:DecorationImage(
                  image: NetworkImage(artical['urlToImage'].toString()),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(width:20),
            Expanded(
                      child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(artical['title'].toString(),maxLines: 4,overflow: TextOverflow.clip,style:Theme.of(context).textTheme.headline5)),
                    Text(artical['publishedAt'].toString(),style:TextStyle(color: Colors.grey) ,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
);

    void navigateTo(context,widget)=> Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>widget)
    );