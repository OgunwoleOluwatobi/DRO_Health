import 'package:dro_test/app/locator.dart';
import 'package:dro_test/core/enums/dialog_type.dart';
import 'package:dro_test/core/models/item.dart';
import 'package:dro_test/core/services/main_service.dart';
import 'package:dro_test/ui/views/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final MainService _mainService = locator<MainService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Map<Item, int> get cart => _mainService.cart;

  int amount = 1;

  void increaseAmount() {
    amount +=1;
    notifyListeners();
  }

  void decreaseAmount() {
    if(amount > 0) {
      amount -=1;
      notifyListeners();
    }
  }

  void addToCart(Item item){
    if(amount == 0) {
      _snackbarService.showSnackbar(message: 'Select number of packs');
    }else {
      _dialogService.showCustomDialog(
        variant: DialogType.confirmation,
        title: item.name
      );
      _mainService.addToCart(item, amount);
      amount = 1;
      notifyListeners();
    }
  }

  void navigateToBag() {
    _navigationService.navigateToView(
      MainView(showBag: true,)
    );
  }
}