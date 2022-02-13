import 'package:flutter/material.dart';
import 'package:myshop/provider/MyProvider.dart';
import 'package:myshop/screens/homepage.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String name, subctg, image;
  final double price;

  DetailScreen({
    this.image,
    this.price,
    this.name,
    this.subctg,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget _buildSingleDetailText() {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price =",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "\₹$tp",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int num = 1;
  double tp;
  @override
  Widget build(BuildContext context) {
    setState(() {
      tp = widget.price * num;
    });
    MyProvider cp = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xfffef0f7),
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
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xfffef0f7),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    color: Color(0xfff8f8f8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 130,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          widget.subctg,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\₹${widget.price}",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (num > 1) {
                                              setState(() {
                                                num--;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            size: 30,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        Text(
                                          num.toString(),
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              num++;
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _buildSingleDetailText(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              icon: Icon(Icons.add_shopping_cart_rounded),
                              label: Text('Add to Cart'),
                              onPressed: () {
                                cp.addToCart(
                                  image: widget.image,
                                  name: widget.name,
                                  price: widget.price,
                                  quantity: num,
                                  subname: widget.subctg,
                                );
                                showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Item added to Cart successfully"),
                                        actions: [
                                          FlatButton(
                                            child: Text("okay"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.redAccent,
                                  onSurface: Colors.grey,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
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
                            )
                          ],
                        ),
                        // ListView.builder(
                        //     itemCount: detail.length,
                        //     itemBuilder: (ctx,index) => _checking(
                        //       dis: detail.elementAt(index),
                        //     ))

                        // for(int i=0; i < detail.length; i++)
                        // _checking(
                        //   dis: detail.elementAt(i)
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 120,
              child: Image(
                  height: 180,
                  //width: 180,
                  image: NetworkImage(widget.image)),
            ),
          ],
        ),
      ),
    );
  }
}
