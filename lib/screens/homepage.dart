import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/model/usermodel.dart';
import 'package:myshop/provider/MyProvider.dart';
import 'package:myshop/screens/about.dart';
import 'package:myshop/screens/contact.dart';
import 'package:myshop/screens/detail_screen.dart';
import 'package:myshop/screens/login.dart';
import 'package:myshop/screens/mycart.dart';
import 'package:myshop/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;
  String dp;
  String email;

  void initState() {
    List<UserModel> user =
        Provider.of<MyProvider>(context, listen: false).userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;
      dp = e.userImage;
      return Container();
    }).toList();

    super.initState();
  }

  Widget _buildSingleFeature({
    context,
    String Title,
    String image,
    String SubTitle,
    double rating,
    double price,
  }) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: 230,
              width: 280,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  Text(
                    Title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    SubTitle,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$rating Ratings",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\₹$price",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleCategory({String image, String name}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 210,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopPart(context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.sort,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_sharp,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => CartPage()));
                    },
                  ),

                ],
              ),
            ),
            Expanded(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: (dp == null) ? AssetImage('images/profileimage.jpg') : NetworkImage(dp),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 250,
                          child: ListTile(
                            title: Text(
                              "Buy something ?",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "\nCheckout here 👇",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildFeatureProduct(context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              //height: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myProvider.getFeatureModelList.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                        image: myProvider
                                            .getFeatureModelList[index].image,
                                        price: myProvider
                                            .getFeatureModelList[index].price,
                                        subctg: myProvider
                                            .getFeatureModelList[index].title,
                                        name: myProvider
                                            .getFeatureModelList[index]
                                            .subtitle,
                                      )));
                        },
                        child: _buildSingleFeature(
                          context: context,
                          SubTitle:
                              myProvider.getFeatureModelList[index].subtitle,
                          Title: myProvider.getFeatureModelList[index].title,
                          price: myProvider.getFeatureModelList[index].price,
                          rating: myProvider.getFeatureModelList[index].rating,
                          image: myProvider.getFeatureModelList[index].image,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart(context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xfff2f3f4),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              //height: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          "slide to see all",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myProvider.getCategoryModelList.length,
                        itemBuilder: (ctx, index) => _buildSingleCategory(
                              image:
                                  myProvider.getCategoryModelList[index].image,
                              name: myProvider.getCategoryModelList[index].name,
                            )),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "some more products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildFeatureProduct(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget _buildMyDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          email ==null ?  Center(child: CircularProgressIndicator()) :
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              //backgroundColor: Colors.white,
              backgroundImage: (dp == null)
                  ? AssetImage('images/profileimage.jpg')
                  : NetworkImage(dp),

            ),
            accountName: Text(name ?? "Name"),
            accountEmail: Text(email ?? "Email"),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(),
                ),
              );
            },
            leading: Icon(
              Icons.person_sharp,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            title: Text("View Profile"),
          ),
          ListTile(
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            leading: Icon(
              Icons.home,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("HomePage"),
          ), //_scaffoldKey.currentState.openDrawer();
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ContactUs(),
                ),
              );
            },
            leading: Icon(
              Icons.contact_phone,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            title: Text("Contact Us"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => About(),
                ),
              );
            },
            leading: Icon(
              Icons.info,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("About"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CartPage(),
                ),
              );
            },
            leading: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("Order"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
            leading: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MyProvider myProvider;

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);
    myProvider.getCategoryProduct();
    myProvider.getFeatureProduct();
    myProvider.getUserData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: _buildMyDrawer(context),
      body: SafeArea(
        //child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _buildTopPart(context),
              _buildBottomPart(context),
            ],
          ),
        ),
      ),
    );
  }
}
