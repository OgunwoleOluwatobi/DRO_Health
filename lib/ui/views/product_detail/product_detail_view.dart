import 'package:dro_test/core/models/item.dart';
import 'package:dro_test/core/utils/size_config.dart';
import 'package:dro_test/ui/styles/brand_color.dart';
import 'package:dro_test/ui/views/product_detail/product_detail_viewmodel.dart';
import 'package:dro_test/ui/widgets/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  final Item product;

  ProductDetailView({Key key, this.product}) : super(key: key);

  final currencyFormatter = NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 2);
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.2), horizontal: SizeConfig.xMargin(context, 4)),
              child: InkWell(
                borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 1.5)),
                onTap: () => model.navigateToBag(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.2), horizontal: SizeConfig.xMargin(context, 2)),
                  decoration: BoxDecoration(
                    color: BrandColors.droPurple,
                    borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 1.5))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/svgs/bag.svg',
                          width: SizeConfig.xMargin(context, 6),
                          height: SizeConfig.yMargin(context, 3),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: SizeConfig.xMargin(context, 1),),
                      Text(
                        '${model.cart.length}',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: SizeConfig.textSize(context, 1.8),
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.yMargin(context, 1),),
                      Container(
                        width: double.infinity,
                        height: SizeConfig.yMargin(context, 28),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: SizeConfig.textSize(context, 2.2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: SizeConfig.textSize(context, 1.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 3)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: SizeConfig.xMargin(context, 5),
                              backgroundColor: Colors.grey[300],
                            ),
                            SizedBox(width: SizeConfig.xMargin(context, 3),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SOLD BY',
                                  style: Theme.of(context).textTheme.headline5.copyWith(
                                    fontSize: SizeConfig.textSize(context, 1.2),
                                    fontWeight: FontWeight.bold,
                                    color: BrandColors.darkGreen.withOpacity(0.5)
                                  ),
                                ),
                                Text(
                                  product.company,
                                  style: Theme.of(context).textTheme.headline5.copyWith(
                                    fontSize: SizeConfig.textSize(context, 1.6),
                                    fontWeight: FontWeight.bold,
                                    color: BrandColors.darkGreen
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26
                                    ),
                                    borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 2))
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => model.decreaseAmount(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.yMargin(context, .8), vertical: SizeConfig.yMargin(context, .5)),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black45
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2)),
                                        child: Text(
                                          '${model.amount}'
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => model.increaseAmount(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.yMargin(context, .8), vertical: SizeConfig.yMargin(context, .5)),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black45
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: SizeConfig.xMargin(context, 1),),
                                Text(
                                  'Pack(s)',
                                  style: Theme.of(context).textTheme.headline5.copyWith(
                                    fontSize: SizeConfig.textSize(context, 1.7),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black12
                                  ),
                                )
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(2, -4),
                                      child: Text(
                                        '₦',
                                        textScaleFactor: 0.7,
                                        style: Theme.of(context).textTheme.headline5.copyWith(
                                          fontSize: SizeConfig.textSize(context, 1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' '+product.price,
                                    style: Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: SizeConfig.textSize(context, 2.2),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                  ),
                                ]
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'PRODUCT DETAILS',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: SizeConfig.textSize(context, 1.7),
                          fontWeight: FontWeight.bold,
                          color: BrandColors.darkGreen.withOpacity(0.7)
                        ),
                      ),
                      SizedBox(height: SizeConfig.yMargin(context, 1.8),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailItem(
                                  context: context,
                                  image: 'assets/svgs/pills.svg',
                                  title: 'PACK SIZE',
                                  value: product.packSize
                                ),
                                SizedBox(height: SizeConfig.yMargin(context, 1.6),),
                                detailItem(
                                  context: context,
                                  image: 'assets/svgs/meds.svg',
                                  title: 'CONSTITUENT',
                                  value: product.constituent
                                ),
                                SizedBox(height: SizeConfig.yMargin(context, 1.6),),
                                detailItem(
                                  context: context,
                                  image: 'assets/svgs/pills-bottle.svg',
                                  title: 'DISPENSED IN',
                                  value: product.dispenseType
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailItem(
                                  context: context,
                                  image: 'assets/svgs/qr-code.svg',
                                  title: 'PRODUCT ID',
                                  value: product.productId
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
              child: FlatButton(
                minWidth: SizeConfig.xMargin(context, 70),
                padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 2.5))
                ),
                color: BrandColors.droPurple,
                onPressed: () => model.addToCart(product),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/bag.svg',
                      width: SizeConfig.yMargin(context, 2.5),
                      color: Colors.white,
                    ),
                    SizedBox(width: SizeConfig.xMargin(context, 3),),
                    Text(
                      'Add to bag',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: SizeConfig.textSize(context, 1.8),
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}