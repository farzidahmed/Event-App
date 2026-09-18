import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:llr/features/friend/presentation/all_friend_list_screen.dart';
import 'package:llr/features/home_screen.dart';
import 'package:llr/features/profile/presentation/profile_screen.dart';
import 'package:llr/features/search/presentation/search_screen.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/networks/api_access.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    AllFriendPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _icons = [
    Assets.icons.home01,
    Assets.icons.search02,
    Assets.icons.inbox,
    Assets.icons.user,
  ];
  @override
  void initState() {
    allAlumsRxObj.all();
    myAllFriendRxObj.allFriend();
    userDetailsRxObj.userDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background bar
          Container(
            height: 75.h,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: const BoxDecoration(color: Color(0xFF121821)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_icons.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.all(8.h),
                    child:
                        isSelected
                            ? SizedBox(
                              height: 65.h,
                              width: 65.h,
                            ) // placeholder space
                            : SvgPicture.asset(
                              _icons[index],
                              height: 28.h,
                              width: 28.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                  ),
                );
              }),
            ),
          ),

          // Floating circular selected icon
          Positioned(
            top: -20.h, // makes it overlap top edge
            left:
                (MediaQuery.of(context).size.width / _icons.length) *
                    _selectedIndex +
                ((MediaQuery.of(context).size.width / _icons.length) / 2) -
                32.5.w,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 65.h,
              width: 65.h,
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  _icons[_selectedIndex],
                  height: 28.h,
                  width: 28.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
