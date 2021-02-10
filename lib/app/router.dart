import 'package:dro_test/core/models/item.dart';
import 'package:dro_test/ui/views/main/main_view.dart';
import 'package:dro_test/ui/views/product_detail/product_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const mainViewRoute = '/main-view';
  static const productDetailsViewRoute = '/product-detail-view';
}

class Routers {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case Routes.mainViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: settings
        );
      case Routes.productDetailsViewRoute:
        Item item = settings.arguments as Item;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ProductDetailView(product: item,),
          settings: settings
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// borrowed from auto_route:
// returns an error page routes with a helper message.
PageRoute unknownRoutePage(String routeName) => CupertinoPageRoute(
  builder: (ctx) => Scaffold(
    body: Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              routeName == "/"
                  ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                  : 'Route name $routeName is not found!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          OutlineButton.icon(
            label: Text('Back'),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    ),
  ),
);