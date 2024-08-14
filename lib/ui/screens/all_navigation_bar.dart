import 'package:flutter/material.dart';
import 'package:flutter_application/ui/screens/auth_screen/profile_screen.dart';
import 'package:flutter_application/ui/screens/resipe_screens/recipe_details_screen.dart';
import 'package:flutter_application/ui/screens/home_screen/home_screen.dart';
import 'package:flutter_svg/svg.dart';

class AllNavigationBar extends StatefulWidget {
  const AllNavigationBar({super.key});

  @override
  State<AllNavigationBar> createState() => _AllNavigationBarState();
}

class _AllNavigationBarState extends State<AllNavigationBar> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF129575),
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    shape: const CircleBorder(),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        currentTab == 0
                            ? "assets/icons/home-active.svg"
                            : "assets/icons/home.svg",
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: const CircleBorder(),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const RecipeDetailsScreen();
                        currentTab = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        currentTab == 1
                            ? "assets/icons/bookmark_active.svg"
                            : "assets/icons/bookmark.svg",
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    shape: const CircleBorder(),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Center(
                          child: Text("This Screen is Empty"),
                        );
                        currentTab = 2;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        currentTab == 2
                            ? "assets/icons/notification-active.svg"
                            : "assets/icons/notification.svg",
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: const CircleBorder(),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();
                        currentTab = 3;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(currentTab == 3
                          ? "assets/icons/profile_active.svg"
                          : "assets/icons/profile.svg"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
