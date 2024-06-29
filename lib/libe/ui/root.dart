import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:nike_ecommerce_flutter/ui/widgets/badge.dart' as nike ;
import 'package:provider/provider.dart';
import 'package:shoestores/libe/data/repo/cart_repository.dart';
import 'package:shoestores/libe/ui/cart/cart.dart';
import 'package:shoestores/libe/ui/home/home.dart';
import 'package:shoestores/libe/ui/profile/profile_screen.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

final StreamController<int> changeSelectedTabItem = StreamController();

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: ChangeNotifierProvider<CartRepository>(
          create: (context) => cartRepository,
          child: Scaffold(
            body: IndexedStack(
              index: selectedScreenIndex,
              children: [
                _navigator(_homeKey, homeIndex, HomeScreen()),
                _navigator(_cartKey, cartIndex, const CartScreen()),
                _navigator(_profileKey, profileIndex, ProfileScreen()),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home), label: 'خانه'),
                BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(CupertinoIcons.cart),
                        Positioned(
                            right: -10,
                            child: ValueListenableBuilder<int>(
                              valueListenable:
                                  CartRepository.cartItemCountNotifier,
                              builder: (context, value, child) {
                                return Badge();
                              },
                            )),
                      ],
                    ),
                    label: 'سبد خرید'),
                const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
              ],
              currentIndex: selectedScreenIndex,
              onTap: (selectedIndex) {
                setState(() {
                  _history.remove(selectedScreenIndex);
                  _history.add(selectedScreenIndex);
                  selectedScreenIndex = selectedIndex;
                });
              },
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }

  StreamSubscription<int>? _subscription;

  @override
  void initState() {
    cartRepository.count();
    _subscription = changeSelectedTabItem.stream.listen((event) {
      setState(() {
        selectedScreenIndex = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
