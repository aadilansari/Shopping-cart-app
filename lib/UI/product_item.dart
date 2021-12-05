import 'dart:ui';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.productImage,
    this.title,
    this.price,
    this.press,
    this.addToCart,
  }) : super(key: key);
  final String productImage, title;
  final double price;
  final Function press;
  final Function addToCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: press,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: 190,
              width: 156,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 30),
                      blurRadius: 30,
                      color: Color(0xFF393939).withOpacity(.1))
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.network(
                        productImage,
                        height: 80,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        // color: Colors.grey[200],
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Text(
                                '\$ ${price}',
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(Icons.shopping_cart_outlined),
                                ),
                                onTap: addToCart,
                              )
                              // IconButton(onPressed: addToCart, icon:Icons.shopping_cart_outlined )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              // ),
            ),
            /*    Positioned(
              bottom: 70,
              right: 20,
              child: FlatButton(
                  color: Color(0xFF845EC2),
                  onPressed: addToCart,
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  )),
            ), */
          ],
        ),
      ),
    );
  }
}
