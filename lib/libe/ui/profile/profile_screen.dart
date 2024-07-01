import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoestores/libe/data/auth_info.dart';
import 'package:shoestores/libe/data/repo/auth_repository.dart';
import 'package:shoestores/libe/data/repo/cart_repository.dart';
import 'package:shoestores/libe/di/di.dart';
import 'package:shoestores/libe/ui/auth/auth.dart';
import 'package:shoestores/libe/ui/favorites/favorite_screen.dart';
import 'package:shoestores/libe/ui/order/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authInfo, child) {
            final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: Icon(Icons.person,color: Colors.blue,size: 50,),
                  ),
                  Text(isLogin ? authInfo.email : 'کاربر میهمان',style: TextStyle(color: Colors.grey),),
                  const SizedBox(
                    height: 32,
                  ),
                  const Divider(
                   indent: 30,
                   endIndent: 30,
                    color: Colors.grey,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavoriteListScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.heart),
                          SizedBox(
                            width: 16,
                          ),
                          Text('لیست علاقه مندی ها'),
                        ],
                      ),
                    ),
                  ),
                  // const Divider(
                  //   indent: 25,
                  //   endIndent: 25,
                  //   color: Colors.blue,
                  //   height: 1,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OrderHistoryScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.cart),
                          SizedBox(
                            width: 16,
                          ),
                          Text('سوابق سفارش'),
                        ],
                      ),
                    ),
                  ),
                  // const Divider(
                  //  indent: 25,
                  //   endIndent: 25,
                  //   color: Colors.blue,
                  //   height: 1,
                  // ),
                  InkWell(
                    onTap: () {
                      if (isLogin) {
                        showDialog(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  title: const Text('خروج از حساب کاربری'),
                                  content: const Text(
                                      'آیا می خواهید از حساب خود خارج شوید؟'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('خیر')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          CartRepository
                                              .cartItemCountNotifier.value = 0;
                                          getIt<IAuthRepository>().signOut();
                                        },
                                        child: const Text('بله')),
                                  ],
                                ),
                              );
                            });
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => const AuthScreen()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: [
                          Icon(isLogin
                              ? CupertinoIcons.arrow_right_square
                              : CupertinoIcons.arrow_left_square),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(isLogin
                              ? 'خروج از حساب کاربری'
                              : 'ورود به حساب کاربری'),
                        ],
                      ),
                    ),
                  ),
                  // const Divider(
                  //  indent: 25,
                  //   endIndent: 25,
                  //   color: Colors.blue,
                  //   height: 1,
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
