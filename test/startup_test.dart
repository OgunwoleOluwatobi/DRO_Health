import 'package:dro_test/app/locator.dart';
import 'package:dro_test/core/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Setup is working', () async{
    TestWidgetsFlutterBinding.ensureInitialized();

    locator.allowReassignment = true;
    setupLogger(test: true);

    await setupLocator(test: true);

    await locator.allReady();
  });
}