import 'package:flutter/material.dart';
import 'package:myshop/provider/MyProvider.dart';
import 'package:myshop/screens/homepage.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget cartItem({
    @required String image,
    @required String name,
    @required double price,
    @required Function onTap,
    @required int quantity,
    @required String subname,
  }) {
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          child: Image.network(image)
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only( right: 20),
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          subname,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("$name",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.lightBlue),
                      ),
                      Text(
                        "\₹$price",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "quantity = $quantity",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_shopping_cart_rounded , color: Colors.redAccent),
                  onPressed: onTap,
                )
              ],
            )),
      ],
    );
  }
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
   int tota = provider.totalprice();
    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 85,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.amberAccent,
              width: 2,
            ),
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price =",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                "\$ $tota",
                style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold,),
              ),
            ],
          ),
              TextButton.icon(
                icon: Icon(Icons.payments),
                label: Text('Buy Now'),
                onPressed: () {},
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.amber,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          )
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Cart",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: ListView.builder(
              itemCount: provider.cartList.length,
              itemBuilder: (ctx, index) {
                provider.getDeleteIndex(index);
                return cartItem(
                  onTap: (){
                    provider.delete();
                  },
                  image: provider.cartList[index].image,
                  name: provider.cartList[index].name,
                  price: provider.cartList[index].price,
                  quantity: provider.cartList[index].quantity,
                  subname: provider.cartList[index].subname,
                );
              },
            ),
    );
  }
}