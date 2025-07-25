import 'package:flutter/material.dart';

import 'package:recipe_book_app/utils/route_generator.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
     initialRoute: RouteGenerator.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    
    //home: const ResponsiveNavigation(),
  ));
}
