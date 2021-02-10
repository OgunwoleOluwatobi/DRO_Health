import 'package:dro_test/core/models/item.dart';
import 'package:stacked/stacked.dart';

class MainService with ReactiveServiceMixin {
  final List<Item> _products = [
    Item(
      name: 'Kezitil Susp',
      image: 'assets/images/kezitil.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '1820',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Kezitil',
      image: 'assets/images/kezitil2.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '2200',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Garlic Oil',
      image: 'assets/images/garlic.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '1000',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Folic Acid',
      image: 'assets/images/folic.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '180',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Kezitil Susp',
      image: 'assets/images/kezitil.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '450',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Kezitil',
      image: 'assets/images/kezitil2.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '1500',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Garlic Oil',
      image: 'assets/images/garlic.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '500',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
    Item(
      name: 'Folic Acid',
      image: 'assets/images/folic.png',
      category: 'Cefuroxime Axetil',
      description: 'Oral Suspension - 125mg',
      price: '320',
      company: 'Emzor Pharmacueticals',
      packSize: '3x10',
      constituent: 'cefuroxime',
      dispenseType: 'Packs',
      productId: 'PKWISM2WM1'
    ),
  ];

  List<Item> get products => _products;

  Map<Item, int> cart = {};

  MainService() {
    listenToReactiveValues([cart]);
  }

  void addToCart(Item item, int amount) {
    if(cart.containsKey(item)) {
      cart[item] = amount;
    } else {
      cart.putIfAbsent(item, () => amount);
    }
    notifyListeners();
  }

  void deleteFromCart(item) {
    cart.remove(item);
    notifyListeners();
  }
}