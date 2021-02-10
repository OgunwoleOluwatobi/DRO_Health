import 'package:dro_test/core/models/item.dart';
import 'package:dro_test/core/utils/size_config.dart';
import 'package:dro_test/ui/styles/brand_color.dart';
import 'package:dro_test/ui/views/main/main_viewmodel.dart';
import 'package:dro_test/ui/widgets/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  final bool showBag;

  MainView({Key key, this.showBag=false}) : super(key: key);

  final Duration duration = Duration(milliseconds: 150);
  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.setup();
        if(showBag) {
          model.setExpand(true);
        }
      },
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Material(
          child: Center(
            child: Stack(
              children: [
                FractionallySizedBox(
                  heightFactor: 0.93,
                  child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      title: Text(
                        '${model.products.length} Item(s)',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: SizeConfig.textSize(context, 2),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      centerTitle: true,
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  actionOption(
                                    context: context,
                                    image: 'assets/svgs/sort.svg'
                                  ),
                                  actionOption(
                                    context: context,
                                    image: 'assets/svgs/filter.svg'
                                  ),
                                  actionOption(
                                    context: context,
                                    image: 'assets/svgs/loupe.svg',
                                    func: () {
                                      FocusScope.of(context).unfocus();
                                      model.setSearch();
                                    }
                                  ),
                                ],
                              ),
                              model.searchMode ? Container(
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1)),
                                child: TextField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.search,
                                  controller: textEditingController,
                                  onChanged: model.updateSearch,
                                  onSubmitted: model.updateSearch,
                                  decoration: InputDecoration(
                                    prefixIcon: Center(
                                      widthFactor: 0.2,
                                      child: SvgPicture.asset(
                                        'assets/svgs/loupe.svg',
                                        width: SizeConfig.xMargin(context, 4),
                                      ),
                                    ),
                                    suffixIcon: textEditingController.text.isEmpty ? SizedBox() : Center(
                                      widthFactor: 0.2,
                                      child: IconButton(
                                        onPressed: () {
                                          textEditingController.text = '';
                                          model.updateSearch('');
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Theme.of(context).iconTheme.color,
                                          size: SizeConfig.xMargin(context, 5),
                                        ),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.6), horizontal: SizeConfig.xMargin(context, 4)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                  ),
                                ),
                              ) : SizedBox()
                            ],
                          ),
                        ),
                        Expanded(
                          child: model.filterProducts.isEmpty ? Center(
                            child: Text(
                              'Product not found',
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: SizeConfig.textSize(context, 2.4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ) : GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4), vertical: SizeConfig.yMargin(context, 2)),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: SizeConfig.xMargin(context, 2),
                              mainAxisSpacing: SizeConfig.xMargin(context, 4),
                              childAspectRatio: .8
                            ),
                            itemCount: model.filterProducts.length,
                            itemBuilder: (c, i) {
                              Item res = model.filterProducts[i];
                              return model.loader ? productLoader(context: context)
                              : InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  model.navigateToDetail(res);
                                },
                                child: productItem(
                                  context: context,
                                  name: res.name,
                                  category: res.category,
                                  description: res.description,
                                  image: res.image,
                                  price: res.price
                                ),
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.yMargin(context, 100),
                  child: NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      if(notification.extent == notification.maxExtent) {
                        model.setCenter(true);
                        model.setHide(false);
                      } else if(notification.extent == notification.minExtent) {
                        model.setExpand(false);
                        model.setHide(true);
                      } else {
                        model.setCenter(false);
                      }
                      return true;
                    },
                    child: DraggableScrollableActuator(
                      child: DraggableScrollableSheet(
                        key: Key(model.initial.toString()),
                        initialChildSize: model.initial,
                        minChildSize: 0.085,
                        maxChildSize: 1,
                        builder: (context, sController){
                          // sController.addListener(() {
                          //   if(sController.position.pixels > sController.position.maxScrollExtent/2) {
                          //     sController.animateTo(sController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
                          //   } else {
                          //     sController.animateTo(sController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
                          //   }
                          // });
                          return Container(
                            decoration: BoxDecoration(
                              color: BrandColors.darkPurple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(SizeConfig.xMargin(context, 6.5)),
                                topRight: Radius.circular(SizeConfig.xMargin(context, 6.5))
                              )
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(SizeConfig.xMargin(context, 6.5)),
                                topRight: Radius.circular(SizeConfig.xMargin(context, 6.5))
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if(!model.expanded && model.initial == 0.085) {
                                          model.setExpand(true);
                                        }
                                      },
                                      onVerticalDragStart: (d) {
                                        if(!model.expanded && model.initial == 0.085) {
                                          model.setExpand(true);
                                        }
                                      },
                                      onVerticalDragEnd: (d) {
                                        if(!model.expanded && model.initial == 0.085) {
                                          model.setExpand(true);
                                        }
                                      },
                                      onVerticalDragCancel: () {
                                        if(!model.expanded && model.initial == 0.085) {
                                          model.setExpand(true);
                                        }
                                      },
                                      // onLongPress: () => model.setExpand(true),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: model.expanded ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : EdgeInsets.zero,
                                              height: SizeConfig.yMargin(context, 2),
                                              child: Center(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, .6)),
                                                  height: 4,
                                                  width: SizeConfig.xMargin(context, 12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(50)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment: model.expanded ? Alignment.center : Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/svgs/shopping-bag.svg',
                                                            width: SizeConfig.xMargin(context, 6),
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: SizeConfig.xMargin(context, 2),),
                                                          Text(
                                                            'Bag',
                                                            style: Theme.of(context).textTheme.headline5.copyWith(
                                                              fontSize: SizeConfig.textSize(context, 2.2),
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    child: Center(
                                                      child: Text(
                                                        '${model.cart.length}',
                                                        style: Theme.of(context).textTheme.headline5.copyWith(
                                                          fontSize: SizeConfig.textSize(context, 1.8),
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    model.cart.isEmpty || model.hide ? SizedBox() : SingleChildScrollView(
                                      controller: sController,
                                      child: Container(
                                        margin: EdgeInsets.only(top: SizeConfig.yMargin(context, 3), bottom: SizeConfig.yMargin(context, 2)),
                                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2), vertical: SizeConfig.yMargin(context, .6)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Text(
                                          'Tap on an item for add, remove and delete options',
                                          style: Theme.of(context).textTheme.headline5.copyWith(
                                            fontSize: SizeConfig.textSize(context, 1.6),
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: model.hide ? EdgeInsets.only(top: SizeConfig.yMargin(context, 1)) : EdgeInsets.zero,
                                        child: SingleChildScrollView(
                                          controller: sController,
                                          physics: AlwaysScrollableScrollPhysics(),
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                model.cart.isEmpty ? Padding(
                                                  padding: const EdgeInsets.only(top: 80.0),
                                                  child: Center(
                                                    child: Text(
                                                      'No Item in Bag.',
                                                      style: Theme.of(context).textTheme.headline5.copyWith(
                                                        fontSize: SizeConfig.textSize(context, 2.4),
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ) : SizedBox.shrink(),
                                                for(Item res in model.cart.keys)
                                                  ListTile(
                                                    onTap: () => model.setMode(res),
                                                    contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1), horizontal: SizeConfig.xMargin(context, 4)),
                                                    leading: AnimatedCrossFade(
                                                      duration: duration,
                                                      crossFadeState: model.editingMode && model.selected == res ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                                      firstChild: CircleAvatar(
                                                        radius: SizeConfig.xMargin(context, 6),
                                                        backgroundColor: Colors.white,
                                                        backgroundImage: AssetImage(
                                                          res.image
                                                        ),
                                                      ),
                                                      secondChild: InkWell(
                                                        onTap: () => model.deleteItem(res),
                                                        child: SvgPicture.asset(
                                                          'assets/svgs/delete.svg',
                                                          color: Colors.white,
                                                          width: SizeConfig.xMargin(context, 6),
                                                        ),
                                                      ),
                                                    ),
                                                    title: Row(
                                                      children: [
                                                        Text(
                                                          '${model.cart[res]}X',
                                                          style: Theme.of(context).textTheme.headline5.copyWith(
                                                            fontSize: SizeConfig.textSize(context, 2),
                                                            color: Colors.white
                                                          ),
                                                        ),
                                                        SizedBox(width: SizeConfig.xMargin(context, 2),),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              res.name,
                                                              style: Theme.of(context).textTheme.headline5.copyWith(
                                                                fontSize: SizeConfig.textSize(context, 2),
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                              ),
                                                            ),
                                                            Text(
                                                              res.category,
                                                              style: Theme.of(context).textTheme.headline4.copyWith(
                                                                fontSize: SizeConfig.textSize(context, 1.6),
                                                                color: Colors.white54
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    trailing: AnimatedCrossFade(
                                                      duration: duration,
                                                      crossFadeState: model.editingMode && model.selected == res ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                                      firstChild: Text(
                                                        currencyFormatter.format(int.parse(res.price)),
                                                        style: Theme.of(context).textTheme.headline5.copyWith(
                                                          fontSize: SizeConfig.textSize(context, 2),
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                        ),
                                                      ),
                                                      secondChild: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: SizeConfig.xMargin(context, 4),
                                                            child: Center(
                                                              child: IconButton(
                                                                padding: EdgeInsets.zero,
                                                                icon: Icon(
                                                                  Icons.remove
                                                                ),
                                                                onPressed: () => model.decrement(res)
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2)),
                                                            child: Text(
                                                              '${model.cart[res]}',
                                                              style: Theme.of(context).textTheme.headline5.copyWith(
                                                                fontSize: SizeConfig.textSize(context, 2),
                                                                color: Colors.white
                                                              ),
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: SizeConfig.xMargin(context, 4),
                                                            child: Center(
                                                              child: IconButton(
                                                                padding: EdgeInsets.zero,
                                                                icon: Icon(
                                                                  Icons.add
                                                                ),
                                                                onPressed: () => model.increment(res)
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    model.cart.isEmpty || !model.expanded ? SizedBox() : SingleChildScrollView(
                                      controller: sController,
                                      child: Column(
                                        children: [
                                          model.cart.isEmpty ? SizedBox.shrink() : Container(
                                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4), vertical: SizeConfig.yMargin(context, 1.5)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total',
                                                      style: Theme.of(context).textTheme.headline5.copyWith(
                                                        fontSize: SizeConfig.textSize(context, 2.2),
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                    SizedBox(width: SizeConfig.xMargin(context, 6),),
                                                    Text(
                                                      '${currencyFormatter.format(model.getTotal())}',
                                                      style: Theme.of(context).textTheme.headline5.copyWith(
                                                        fontSize: SizeConfig.textSize(context, 2.2),
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: SizeConfig.yMargin(context, 1.5),),
                                                FlatButton(
                                                  minWidth: SizeConfig.xMargin(context, 70),
                                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.8)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: (){},
                                                  child: Text(
                                                    'Checkout',
                                                    style: Theme.of(context).textTheme.headline5.copyWith(
                                                      fontSize: SizeConfig.textSize(context, 2.2),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}