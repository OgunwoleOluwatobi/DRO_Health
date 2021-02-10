import 'package:dro_test/app/locator.dart';
import 'package:dro_test/core/enums/dialog_type.dart';
import 'package:dro_test/ui/widgets/dialogs/confirm_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialog() {
  final DialogService _dialogService = locator<DialogService>();

  final builders = {
    DialogType.confirmation: (context, sheetRequest, completer) => ConfirmDialog(request: sheetRequest, completer: completer),
  };

  _dialogService.registerCustomDialogBuilders(builders);
}