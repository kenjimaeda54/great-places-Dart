import 'package:flutter/material.dart';
import 'package:projects_dart/providers/GreatPlacesProvider.dart';
import 'package:projects_dart/screens/DetailsLocationScreen.dart';
import 'package:projects_dart/screens/ListPlaceScreen.dart';
import 'package:projects_dart/screens/PlaceFormScreen.dart';
import 'package:projects_dart/utils/ConstantRoute.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatePlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.amber,
            )),
        home: const ListPlaceScreen(),
        routes: {
          ConstantRoute.placeForm: (ctx) => const PlaceFormScreen(),
          ConstantRoute.listPlaces: (ctx) => const ListPlaceScreen(),
          ConstantRoute.detailsPlace: (ctx) => const DetailsLocationScreen()
        },
      ),
    );
  }
}
