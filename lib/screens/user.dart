import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/consts/firebase_consts.dart';
import 'package:demo/screens/auth/forget_pass.dart';
import 'package:demo/screens/edit_profile.dart';
import 'package:demo/screens/loading_manager.dart';
import 'package:demo/screens/wishlist/wishlist_screen.dart';
import 'package:demo/services/global_methods.dart';
import 'package:demo/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../utils/custom_color.dart';
import '../utils/dimensions.dart';
import '../utils/size.dart';
import '../widgets/button/primary_button.dart';
import '../widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('shipping-address');
        _addressTextController.text = userDoc.get('shipping-address');
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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: LoadingManager(
      isLoading: _isLoading,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(Dimensions.heightSize),
            _profilePicture(),
            _profileTitleWidget(context, color),
            _editProfileButtonwidget(context),
            _listTiles(
              title: 'Address',
              subtitle: address,
              icon: IconlyLight.location,
              onPressed: () async {},
              color: color,
            ),
            Visibility(
              visible: _email == null ? false : true,
              child: _listTiles(
                title: 'Favourite Home',
                icon: IconlyLight.heart,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: WishlistScreen.routeName);
                },
                color: color,
              ),
            ),
            _listTiles(
              title: 'Forget password',
              icon: IconlyLight.unlock,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordScreen(),
                  ),
                );
              },
              color: color,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: Dimensions.marginSize * 0.4,
                horizontal: Dimensions.marginSize * 2,
              ),
              child: Row(
                children: [
                  Icon(
                    themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                  addHorizontalSpace(Dimensions.widthSize),
                  TextWidget(
                    text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                    color: color,
                    textSize: 18,
                    // isTitle: true,
                  ),
                  addHorizontalSpace(Dimensions.widthSize * 3),
                  SizedBox(
                    height: 10,
                    width: 20,
                    child: Switch(
                      value: themeState.getDarkTheme,
                      onChanged: (bool value) {
                        setState(() {
                          themeState.setDarkTheme = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.marginSize * 0.4,
          horizontal: Dimensions.marginSize * 2),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            Icon(icon),
            addHorizontalSpace(Dimensions.widthSize),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontSize: Dimensions.mediumTextSize * 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Visibility(
                  visible: subtitle == null ? false : true,
                  child: Text(
                    subtitle ?? "",
                    style: TextStyle(
                      color: CustomColor.deepGrapColor,
                      fontSize: Dimensions.smallTextSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _profilePicture() {
    return Container(
      padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.1),
      margin: EdgeInsets.only(top: Dimensions.marginSize * 1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: CustomColor.borderColor, width: 4),
      ),
      child: CircleAvatar(
        radius: Dimensions.radius * 7.2,
        backgroundColor: CustomColor.primaryColor.withOpacity(0.6),
        backgroundImage: const AssetImage(Assets.profileImg),
      ),
    );
  }

  _profileTitleWidget(BuildContext context, color) {
    return Column(
      children: [
        addVerticalSpace(Dimensions.heightSize * 1.2),
        Text(
          _name ?? 'Guest',
          style: TextStyle(
            color: color,
            fontSize: Dimensions.extraLargeTextSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          _email == null ? 'Email' : _email!,
          style: TextStyle(
            color: CustomColor.deepGrapColor,
            fontSize: Dimensions.mediumTextSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        addVerticalSpace(Dimensions.heightSize * 2)
      ],
    );
  }

  _editProfileButtonwidget(BuildContext context) {
    showSnackBar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
      ));
    }

    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSize * 5,
        right: Dimensions.marginSize * 5,
        bottom: Dimensions.marginSize,
      ),
      child: PrimaryButton(
        title: 'Edit Profile',
        onPressed: () {
          if (authInstance.currentUser != null) {
            GlobalMethods.navigateTo(
              ctx: context,
              routeName: EditProfileScreen.routeName,
            );
          } else {
            showSnackBar('profile edit not allow in guest mode');
          }
        },
      ),
    );
  }
}
