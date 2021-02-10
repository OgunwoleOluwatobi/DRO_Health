import 'package:dro_test/app/locator.dart';
import 'package:dro_test/core/utils/size_config.dart';
import 'package:dro_test/ui/styles/brand_color.dart';
import 'package:dro_test/ui/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  ConfirmDialog({Key key, this.request, this.completer}) : super(key: key);

  final NavigationService _navigationService = locator<NavigationService>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: SizeConfig.yMargin(context, 35),
          width: SizeConfig.xMargin(context, 60),
          child: Stack(
            children: [
              Positioned(
                top: SizeConfig.xMargin(context, 7.5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4), vertical: SizeConfig.yMargin(context, 2)),
                  height: SizeConfig.yMargin(context, 29),
                  width: SizeConfig.xMargin(context, 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 2))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: SizeConfig.xMargin(context, 6),),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Successful',
                              style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: SizeConfig.textSize(context, 2),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: SizeConfig.yMargin(context, .8),),
                            Text(
                              '${request.title} has been added to your bag',
                              style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: SizeConfig.textSize(context, 1.8),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        minWidth: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5)),
                        color: BrandColors.droTurquoise,
                        onPressed: () {
                          completer(DialogResponse());
                          _navigationService.navigateToView(MainView(showBag: true,));
                        },
                        child: Text(
                          'View Bag',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: SizeConfig.textSize(context, 2),
                            color: Colors.white
                          ),
                        ),
                      ),
                      FlatButton(
                        minWidth: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5)),
                        color: BrandColors.droTurquoise,
                        onPressed: () => completer(DialogResponse()),
                        child: Text(
                          'Done',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: SizeConfig.textSize(context, 2),
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: SizeConfig.xMargin(context, 7.5),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: BrandColors.droTurquoise,
                      radius: SizeConfig.xMargin(context, 6.8),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: SizeConfig.yMargin(context, 5),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}