import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_cart/model/shop.dart';
import 'package:shop_cart/shop/bloc/shop_bloc.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShopItem> cartItems;
  double totalAmount = 0;
  void calculateTotalAmount(List<ShopItem> list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ShopPageLoadedState) {
          cartItems = state.cartData.shopitems;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }

        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Center(
              child: Text(
                'My Cart',
              ),
            ),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 3,
                    color: Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 4,
                    color: Color(0xFF000000).withOpacity(0.14),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Total Items',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text('${cartItems.length.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('Grand Total',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text('\$${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: cartItems == null || cartItems.length == 0
              ? Center(child: Text('Your Cart is Empty'))
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      cartItems[index].imageUrl,
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(children: [
                                    Text(cartItems[index].title),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            if (cartItems[index].quantity > 0)
                                              setState(() {
                                                calculateTotalAmount(cartItems);
                                                cartItems[index].quantity--;
                                              });
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: 30,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.5)),
                                            child: Text(
                                              cartItems[index]
                                                  .quantity
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              calculateTotalAmount(cartItems);
                                              cartItems[index].quantity++;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ]),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        if (state is ShopPageLoadedState) {
                                          state.cartData.shopitems
                                              .removeAt(index);
                                          calculateTotalAmount(cartItems);
                                          BlocProvider.of<ShopBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems:
                                                    state.cartData.shopitems));
                                        } else if (state
                                            is ItemAddedCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          BlocProvider.of<ShopBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems));
                                        } else if (state
                                            is ItemDeletingCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          BlocProvider.of<ShopBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    '\$${cartItems[index].price * cartItems[index].quantity} ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
