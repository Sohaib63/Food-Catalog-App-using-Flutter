import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:madproject/models/cart_attr.dart';
import 'package:madproject/pages/online_store/consts/colors.dart';
import 'package:madproject/pages/online_store/inner_screens/products_details_screen.dart';
import 'package:madproject/providers/cart_provider.dart';
import 'package:madproject/widgets/navigation.dart';
import 'package:madproject/widgets/show_alert_dialog.dart';

import '../../constants.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({this.productId});

  // final String id;
  // final String productId;
  // final double price;
  // final int quatity;
  // final String title;
  // final String imageUrl;

  // const CartFull(
  //     {@required this.id,
  //     @required this.productId,
  //     @required this.price,
  //     @required this.quatity,
  //     @required this.title,
  //     @required this.imageUrl});
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  Future<void> _confirmDeleteItemFromCart(BuildContext context,
      String deleteTitle, String deleteSubtitle, Function fct) async {
    final didRequestSignOut = await showAlertDialogue(context,
        title: deleteTitle,
        content: deleteSubtitle,
        defaultactiontext: "OK",
        cancelactiontext: "Cancel");
    if (didRequestSignOut == true) {
      fct();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartAttr = Provider.of<CartAttr>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => circularNavigate(
        context,
        page: ProductDetails(
          productId: widget.productId,
        ),
        offset: Offset(size.width / 2, size.height / 2),
      ),
      child: Container(
        height: 135,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Constants.color2,
          ),
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          // color: Theme.of(context).accentColor,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(cartAttr.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cartAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              _confirmDeleteItemFromCart(
                                  context,
                                  "Remove Item!",
                                  "Product will me removed from you cart, this action can't be undone are you sure you want to continue ",
                                  () => cartProvider
                                      .removeItem(widget.productId));
                              // cartProvider.removeItem(widget.productId);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${cartAttr.price}\$',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sub Total:'),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${subTotal.toStringAsFixed(2)} \$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Ships Free',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: cartAttr.quantity < 2
                                ? null
                                : () {
                                    cartProvider.reduceItemByOne(
                                        widget.productId,
                                        cartAttr.price,
                                        cartAttr.title,
                                        cartAttr.imageUrl);
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: cartAttr.quantity < 2
                                      ? Colors.grey
                                      : Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ], stops: [
                                0.0,
                                0.7
                              ]),
                            ),
                            child: Text(
                              cartAttr.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.addProductToCart(
                                  widget.productId,
                                  cartAttr.price,
                                  cartAttr.title,
                                  cartAttr.imageUrl);
//                              cartProvider.addProductToCart(
//                                  widget.productId,
//                                  cartAttr.price,
//                                  cartAttr.title,
//                                  cartAttr.imageUrl);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.plus,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
