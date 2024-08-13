import 'package:flutter/material.dart';
import 'package:flutter_application/logic/cubits/home_screen_cubits.dart';
import 'package:flutter_application/model/user.dart';
import 'package:flutter_application/ui/views/screens/home_screen/example.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = UserModel(
    email: 'golibtoramurodov@gmail.com',
    name: 'Malfoy',
    imageUrl: 'assets/images/malfoy.png',
    uId: 'testid1',
    likes: [],
    saved: [],
  );

  List<String> categories = [
    'All',
    'Latest',
    'Trending',
    'Short',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubits, int>(builder: (
        context,
        selectedIndex,
      ) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
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
                const SizedBox(height: 20),
                SizedBox(
                  height: 46,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<HomeScreenCubits>()
                                  .changeIndex(index);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFFC1C1C1),
                                ),
                                color: selectedIndex == index
                                    ? const Color(0xFFFF9B05)
                                    : Colors.white,
                              ),
                              width: 100,
                              height: 46,
                              alignment: Alignment.center,
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: index == selectedIndex
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  ' All recipes',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: Example.ingredients.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        height: 200,
                        width: 335,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9B05),
                          borderRadius: BorderRadius.circular(8),
                          // image: DecorationImage(
                          //     image: AssetImage(
                          //         Example.ingredients[index].imageUrl),
                          //     fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
