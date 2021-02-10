import 'dart:async';

import 'package:dro_test/app/locator.dart';
import 'package:dro_test/app/router.dart';
import 'package:dro_test/core/models/item.dart';
import 'package:dro_test/core/services/main_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends ReactiveViewModel {
  final MainService _mainService = locator<MainService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Item> get products => _mainService.products;

  Map<Item, int> get cart => _mainService.cart;
  
  List<Item> filterProducts;

  Item selected;

  bool expanded = false;

  bool searchMode = false;

  bool editingMode = false;

  bool hide = true;

  bool loader = true;

  double initial = 0.085;

  void setup() async{
    filterProducts = _mainService.products;
    await Future.delayed(Duration(seconds: 3), () {
      loader = false;
    });
    notifyListeners();
  }

  void setCenter(bool val) {
    expanded = val;
    notifyListeners();
  }

  void setMode(Item item) {
    selected = item;
    editingMode = !editingMode;
    notifyListeners();
  }

  void setHide(bool val) {
    hide = val;
    notifyListeners();
  }

  void setSearch() {
    searchMode = !searchMode;
    notifyListeners();
  }

  void setExpand(bool expand) {
    initial = expand ? 1 : 0.085;
    if(expand && !expanded) {
      expanded = true;
      hide = false;
    }
    notifyListeners();
  }

  void updateSearch(String val) {
    filterProducts = products.where((element) => element.name.toLowerCase().contains(val.toLowerCase())).toList();
    notifyListeners();
  }

  int getTotal() {
    int amt = 0;
    for(Item item in cart.keys) {
      amt+=(int.tryParse(item.price)*cart[item]);
    }
    return amt;
  }

  void increment(Item item) {
    _mainService.addToCart(item, cart[item]+1);
  }

  void decrement(Item item) {
    if(cart[item] > 1) {
      _mainService.addToCart(item, cart[item]-1);
    }
  }

  void deleteItem(Item item) {
    _mainService.deleteFromCart(item);
  }

  void navigateToDetail(Item item) {
    _navigationService.navigateTo(
      Routes.productDetailsViewRoute,
      arguments: item
    );
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_mainService];
}