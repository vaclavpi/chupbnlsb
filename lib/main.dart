
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_logics.dart';
import 'package:honest_guide/services/data_services.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override¨7
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brandýs nad Labem - Stará Bolesalv',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      primarySwatch:  Colors.grey,
      ),
      home:BlocProvider<AppCubits>(
        create:(context)=>AppCubits(
          data:DataServices(),
        ),
        child:const AppCubitLogics(),
      )
    );
  }
}

