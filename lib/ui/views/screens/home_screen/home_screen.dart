import 'package:flutter/material.dart';
import 'package:flutter_application/model/user.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = UserModel(
      email: 'golibtoramurodov@gmail.com',
      name: 'G\'olibjon',
      imageUrl: 'assets/images/malfoy.png',
      uId: 'testid1',
      likes: [],
      saved: []);
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    const Color.fromRGBO(233, 30, 99, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${user.name}',
                        style: const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
                      ),
                      const Text(
                        'What are you cooking today?',
                        style: TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 47,
                    width: 47,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/malfoy.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  labelText: 'Search recipes',
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/svg/search_icon.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}


//  Expanded(
//                 child: StaggeredGridView.countBuilder(
//                   crossAxisCount: 4,
//                   itemCount: colors.length,
//                   itemBuilder: (BuildContext context, int index) =>
//                       Container(color: colors[index]),
//                   staggeredTileBuilder: (int index) =>
//                       StaggeredTile.count(2, index.isEven ? 2 : 1),
//                   mainAxisSpacing: 10.0,
//                   crossAxisSpacing: 10.0,
//                 ),
//               ),