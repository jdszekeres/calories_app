import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late PersistentTabController _controller;
  late String currentPage;
  @override
  void initState() {
    super.initState();
    currentPage = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    _controller = PersistentTabController(
      initialIndex: currentPage == '/'
          ? 0
          : currentPage == '/goals'
          ? 1
          : currentPage == '/add'
          ? 2
          : currentPage == '/list'
          ? 3
          : currentPage == '/settings'
          ? 4
          : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _BottomNavStyle16(
      selectedIndex: _controller.index,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/goals');
            break;
          case 2:
            context.go('/add');
            break;
          case 3:
            context.go('/list');
            break;
          case 4:
            context.go('/settings');
            break;
          default:
            break;
        }
      },
      navBarHeight: 60,
      navBarDecoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        colorBehindNavBar: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.fastfood),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.list),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        // Navigator.pushNamed(context, '/page$index');
      ],
    );
  }
}

class _BottomNavStyle16 extends StatelessWidget {
  const _BottomNavStyle16({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.navBarHeight,
    final Key? key,
    this.navBarDecoration = const NavBarDecoration(),
  }) : super(key: key);
  final NavBarDecoration? navBarDecoration;
  final EdgeInsets padding = const EdgeInsets.all(0);
  final List<PersistentBottomNavBarItem> items;
  final int selectedIndex;
  final Function(int index)? onItemSelected;
  final double navBarHeight;

  Widget _buildItem(
    final PersistentBottomNavBarItem item,
    final bool isSelected,
    final double? height,
  ) => Container(
    width: 150,
    height: height,
    padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
    child: Container(
      alignment: Alignment.center,
      height: height,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: item.iconSize,
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : Colors.white,
                  ),
                  child: isSelected
                      ? item.icon
                      : item.inactiveIcon ?? item.icon,
                ),
              ),
              if (item.title == null)
                const SizedBox.shrink()
              else
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Material(
                    type: MaterialType.transparency,
                    child: FittedBox(
                      child: Text(
                        "",
                        style: item.textStyle != null
                            ? (item.textStyle!.apply(
                                color: isSelected
                                    ? (item.activeColorSecondary ??
                                          item.activeColorPrimary)
                                    : item.inactiveColorPrimary,
                              ))
                            : TextStyle(
                                color: isSelected
                                    ? (item.activeColorSecondary ??
                                          item.activeColorPrimary)
                                    : item.inactiveColorPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
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
  );

  Widget _buildMiddleItem(
    final BuildContext context,
    final PersistentBottomNavBarItem item,
    final bool isSelected,
    final double? height,
  ) => Padding(
    padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
    child: Stack(
      children: <Widget>[
        Transform.translate(
          offset: const Offset(0, -23),
          child: Center(
            child: Container(
              width: height! - 5.0,
              height: height - 5.0,
              margin: const EdgeInsets.only(top: 2, left: 6, right: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                border: Border.all(color: Colors.transparent, width: 5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: navBarDecoration!.boxShadow,
              ),
              child: Container(
                alignment: Alignment.center,
                height: height,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: IconTheme(
                            data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? item.activeColorSecondary ??
                                        item.activeColorPrimary
                                  : Colors.white,
                            ),
                            child: isSelected
                                ? item.icon
                                : item.inactiveIcon ?? item.icon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (item.title == null)
          const SizedBox.shrink()
        else
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                child: Text(
                  item.title!,
                  style: item.textStyle != null
                      ? (item.textStyle!.apply(
                          color: isSelected
                              ? (item.activeColorSecondary ??
                                    item.activeColorPrimary)
                              : item.inactiveColorPrimary,
                        ))
                      : TextStyle(
                          color: isSelected
                              ? (item.activeColorPrimary)
                              : item.inactiveColorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                ),
              ),
            ),
          ),
      ],
    ),
  );

  @override
  Widget build(final BuildContext context) {
    final midIndex = (items.length / 2).floor();
    return Container(
      width: double.infinity,
      height: navBarHeight,
      color: navBarDecoration?.colorBehindNavBar ?? Colors.transparent,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: navBarDecoration!.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items.map((final item) {
                  final int index = items.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        // if (index != selectedIndex) {
                        //   items[index].iconAnimationController?.forward();

                        //   items[selectedIndex].iconAnimationController
                        //       ?.reverse();
                        // }

                        onItemSelected?.call(index);
                      },
                      child: index == midIndex
                          ? Container(width: 150, color: Colors.transparent)
                          : _buildItem(
                              item,
                              selectedIndex == index,
                              navBarHeight,
                            ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (navBarHeight == 0)
            const SizedBox.shrink()
          else
            Center(
              child: GestureDetector(
                onTap: () {
                  onItemSelected?.call(midIndex);
                },
                child: _buildMiddleItem(
                  context,
                  items[midIndex],
                  selectedIndex == midIndex,
                  navBarHeight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
