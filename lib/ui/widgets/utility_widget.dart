import 'package:dro_test/core/utils/size_config.dart';
import 'package:dro_test/ui/styles/brand_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

final currencyFormatter = NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 0);

Widget actionOption({BuildContext context, String image, Function func}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 6)),
    child: InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: func,
      child: CircleAvatar(
        radius: SizeConfig.xMargin(context, 5),
        backgroundColor: Colors.grey[200],
        child: Center(
          child: SvgPicture.asset(
            '$image',
            width: SizeConfig.xMargin(context, 4.5),
          ),
        ),
      ),
    ),
  );
}

Widget productItem({BuildContext context, String name, String category, String description, String image, String price}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 2))
    ),
    color: Theme.of(context).backgroundColor,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2), vertical: SizeConfig.yMargin(context, 1)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.yMargin(context, 16),
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, .8),),
          Text(
            name,
            style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: SizeConfig.textSize(context, 2),
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            category,
            style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: SizeConfig.textSize(context, 1.6),
            ),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: SizeConfig.textSize(context, 1.6),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 3), vertical: SizeConfig.yMargin(context, .4)),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  currencyFormatter.format(int.tryParse(price)),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: SizeConfig.textSize(context, 1.6),
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).backgroundColor
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget productLoader({BuildContext context}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SizeConfig.xMargin(context, 2))
    ),
    color: Theme.of(context).backgroundColor,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2), vertical: SizeConfig.yMargin(context, 1)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[50],
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              height: SizeConfig.yMargin(context, 16),
              width: double.infinity,
            ),
            SizedBox(height: SizeConfig.yMargin(context, .8),),
            Container(
              color: Theme.of(context).backgroundColor,
              height: SizeConfig.yMargin(context, 1.6),
              width: SizeConfig.xMargin(context, 25),
            ),
            SizedBox(height: SizeConfig.yMargin(context, .5),),
            Container(
              color: Theme.of(context).backgroundColor,
              height: SizeConfig.yMargin(context, 1),
              width: SizeConfig.xMargin(context, 20),
            ),
            SizedBox(height: SizeConfig.yMargin(context, .5),),
            Container(
              color: Theme.of(context).backgroundColor,
              height: SizeConfig.yMargin(context, 1),
              width: SizeConfig.xMargin(context, 18),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  height: SizeConfig.yMargin(context, 2),
                  width: SizeConfig.xMargin(context, 13),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget detailItem({BuildContext context, String image, String title, String value}) {
  return Row(
    children: [
      Container(
        width: SizeConfig.xMargin(context, 5.5),
        child: SvgPicture.asset(
          image,
          color: BrandColors.droPurple,
          width: SizeConfig.xMargin(context, 5.5),
        ),
      ),
      SizedBox(width: SizeConfig.xMargin(context, 2),),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4.copyWith(
              fontSize: SizeConfig.textSize(context, 1.2),
              color: Colors.black38
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headline4.copyWith(
              fontSize: SizeConfig.textSize(context, 1.8),
              fontWeight: FontWeight.bold,
              color: Color(0xFF728B94)
            ),
          ),
        ],
      )
    ],
  );
}