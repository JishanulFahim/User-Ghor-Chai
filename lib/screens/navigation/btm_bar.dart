// ignore_for_file: unnecessary_null_comparison, unused_field

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo/providers/bottom_nav_bar_provider.dart';
import 'package:demo/screens/PostScreen/main_page.dart';
import 'package:demo/screens/auth/register.dart';
import 'package:demo/screens/drawer/about_us_screen.dart';
import 'package:demo/screens/drawer/how_to_use_screen.dart';
import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/navigator.dart';
import 'package:demo/utils/size.dart';
import 'package:demo/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../services/global_methods.dart';
import '../../widgets/appbar/custom_app_bar.dart';
import '../../widgets/bottom_navigation_menu.dart';
import '../auth/login.dart';
import '../wishlist/wishlist_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getConnectivity();
    getUserData();
    super.initState();
  }

  //
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => const BottomBarScreen(),
            ));
          }
        },
      );

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('shipping-address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

////
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  /////

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Name: Mukbul Hossain\nPhone: 01856199643\nAddress: Ashulia Bazar, Ashulia",
      "Name: Sajal\nPhone: 01763588204\nAddress: Mohakhali Fly Over, Mohakhali",
      "Name: Fahim\nPhone: 01818214833\nAddress: 231 Green Road, Dhanmondi",
      'Name: Sifat\nPhone: 01772842199\nAddress: Mirpur 2, Mirpur',
      "Name: Yasir\nPhone: 01716756380\nAddress: Banani DOHS, Banani",
      "Name: Fahad\nPhone: 01751884655\nAddress: Gulshan 2, Gulshan",
      "Name: Hasan\nPhone: 01839327941\nAddress: Kallayanpur Bus Stop, Kallayanpur"
    ];
    final themeState = Provider.of<DarkThemeProvider>(context);
    var controller = Provider.of<BottomNavigationBarProvider>(context);

    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 150,
              color: CustomColor.primaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'assets/AppIcon/luncher_icon.png',
                      scale: 10,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('GHOR CHAI',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(
                        "Keep Calm and Let's find\nyou A New Home.",
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  )
                ],
              ),
            ),
            _email == null
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.marginSize * 0.6,
                          vertical: Dimensions.marginSize * 0.6,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/AppIcon/LoginOrregister.png',
                              scale: 15,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      LoginScreen.routeName,
                                    );
                                  },
                                  child: const Text(
                                    'Login/',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      RegisterScreen.routeName,
                                    );
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1.5),
                    ],
                  )
                : Container(),
            const SizedBox(height: 15),
            Visibility(
                visible: _email == null ? false : true,
                child: drawerButton(
                    text: 'Favourite',
                    path: 'assets/AppIcon/Dashboard/Favorite.png',
                    onTao: () {
                      GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: WishlistScreen.routeName,
                      );
                    })),
            drawerButton(
                text: 'Contact Us',
                path: 'assets/AppIcon/Dashboard/contact.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(
                        title: 'Contact Us',
                      ),
                    ),
                  );
                }),
            drawerButton(
              text: 'Membership',
              path: 'assets/AppIcon/Dashboard/membership.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoScreen(
                      title: 'Membership',
                    ),
                  ),
                );
              },
            ),
            const Divider(thickness: 1.5),
            drawerButton(
                text: 'About Us',
                path: 'assets/AppIcon/Dashboard/About us.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(
                        title: 'About Us',
                      ),
                    ),
                  );
                }),
            drawerButton(
              text: 'Privacy Policy',
              path: 'assets/AppIcon/Dashboard/Privacy Policy.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoScreen(
                      title: 'Terms & Policies',
                    ),
                  ),
                );
              },
            ),
            drawerButton(
              text: 'Electrician',
              path: 'assets/AppIcon/MyAds/My Ads.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Electrician(
                      title: 'Electrician',
                      list: list,
                    ),
                  ),
                );
              },
            ),
            drawerButton(
              text: 'Plumber',
              path: 'assets/AppIcon/Dashboard/feedback Share.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Electrician(
                      title: 'Plumber',
                      list: list,
                    ),
                  ),
                );
              },
            ),
            drawerButton(
                text: 'How to Use',
                path: 'assets/AppIcon/Dashboard/How to Use.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HowToUseScreen(),
                    ),
                  );
                }),
            addVerticalSpace(Dimensions.heightSize * 3),
            Visibility(
              visible: _email == null ? false : true,
              child: const Divider(thickness: 1.5),
            ),
            Visibility(
              visible: _email == null ? false : true,
              child: ListTile(
                contentPadding:
                    EdgeInsets.only(left: Dimensions.marginSize * 2.5),
                leading: Image.asset(
                  'assets/AppIcon/logout.png',
                  scale: 15,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  GlobalMethods.warningDialog(
                      title: 'Sign out',
                      subtitle: 'Do you wanna sign out?',
                      fct: () async {
                        await authInstance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      context: context);
                },
              ),
            )
          ],
        ),
      ),
      appBar: controller.currentIndex == 0
          ? AppBar(
              backgroundColor:
                  isDark ? const Color(0xFF0a0d2c) : CustomColor.primaryColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: TextWidget(
                text: 'GHOR CHAI',
                color: Colors.white,
                textSize: 30,
                isTitle: true,
              ),
              centerTitle: true,
            )
          : CustomAppBar(
              titleClr: isDark ? Colors.white : Colors.black,
              bgClr: Theme.of(context).scaffoldBackgroundColor,
              controller.currentIndex == 1
                  ? 'Categories'
                  : controller.currentIndex == 2
                      ? 'My Ads'
                      : 'Profile',
              centerTitle: true,
              alwaysShowBackButton: false,
              elevation: 5,
            ),
      extendBody: true,
      backgroundColor: CustomColor.transparent,
      body: controller.page[controller.currentIndex],
      bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      floatingActionButton: _floatingActionButtonWidget(context, isDark),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  drawerButton({
    required String path,
    required String text,
    required VoidCallback onTao,
  }) {
    return ListTile(
      leading: Image.asset(
        path,
        scale: 15,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: text == 'Logout' ? CustomColor.redClr : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      onTap: onTao,
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          //title: const Text('No Connection'),
          content: Column(
            children: [
              Image.asset("assets/images/internet.png",
                  height: 250, width: 400, fit: BoxFit.cover),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Opps",
                style: TextStyle(fontSize: 22, color: Colors.amber),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('No Connection'),
              const Text(
                'Please check your internet connectivity',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  _floatingActionButtonWidget(BuildContext context, isDark) {
    return _isLoading
        ? const CircularProgressIndicator()
        : FloatingActionButton(
            onPressed: () {
              if (_email != null) {
                Navigators.goTo(context, page: const MainPage());
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );

                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Container(
                //           height: 30,
                //           color: Colors.red,
                //         ),
                //       ],
                //     );
                //   },
                // );
              }
            },
            child: const Icon(Icons.add_rounded),
            backgroundColor:
                isDark ? const Color(0xFF0a0d2c) : CustomColor.primaryColor,
          );
  }
}
