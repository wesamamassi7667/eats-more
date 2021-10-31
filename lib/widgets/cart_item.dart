import 'package:eat_more_app/component/cart_dialog.dart';
import 'package:eat_more_app/component/image_card.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/widgets/counter_cart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color.dart';

class CartItem extends StatelessWidget {
  final Function pressDelete;
  final int index;
  final Order order;
  final ProductCart productCart;
  final Function pressPlus;
  final int selectedIndex;
  final Function pressMines;

  const CartItem({
    Key key,
    this.pressDelete,
    this.index,
    this.order,
    this.productCart,
    this.pressPlus,
    this.selectedIndex,
    this.pressMines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCard(
              width: 84,
              height: 85,
              url: productCart.product_image,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${productCart.product_name}',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Bun 5 inch, grilled chicken patty,tomatoes, lettuce and mayonnaise.',
                      style: TextStyle(fontSize: 13, color: grey6),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    productCart.addons != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        CartDialog(addons: productCart.addons));
                              },
                              child: Text(
                                AppLocalization.of(context).translate('addons'),
                              ),
                              style: AppThemeData.buttonStyle(
                                  borderRadius: 6,
                                  fontSize: 10,
                                  height: 24,
                                  width: 56),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            CountCartWidget(
              isCart: true,
              quantity: productCart.quantity,
              pressPlus: pressPlus,
              pressMines: pressMines,
            ),
          ],
        ),
        IconButton(
          onPressed: pressDelete,
          icon: Icon(
            Icons.delete_forever,
            color: red,
          ),
        ),
      ],
    );
  }
}
