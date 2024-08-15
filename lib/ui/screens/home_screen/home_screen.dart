import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_application/logic/bloc/home/home_bloc.dart';
import 'package:flutter_application/logic/cubits/home_screen_cubits.dart';
import 'package:flutter_application/ui/screens/resipe_screens/recipe_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/toggleLike_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

  void getCurrentUserInfo() async {
    var uId = await FirebaseUserService.getId();
    user = await FirebaseUserService().getUser(uId ?? '-O4IXSJTsQHmGrM-Oovx');
    AppConstants.uId = uId!;
    AppConstants.userModel = user;
    setState(() {});
  }

  List<String> categories = [
    'All',
    'Latest',
    'Trending',
    'Short',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeBloc>().add(FetchRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubits, int>(
        builder: (context, selectedIndex) {
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
                            'Hello ${user?.name ?? 'Guest'}',
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
                          image: DecorationImage(
                            image: (user?.imageUrl == null ||
                                    user!.imageUrl.isEmpty)
                                ? const AssetImage('assets/images/malfoy.png')
                                    as ImageProvider
                                : NetworkImage(user!.imageUrl) as ImageProvider,
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
                        children: List.generate(categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<HomeScreenCubits>()
                                  .changeIndex(index);
                              if (categories[index] == 'Latest') {
                                context
                                    .read<HomeBloc>()
                                    .add(GetLatestRecipesEvent());
                              } else if (categories[index] == 'Trending') {
                                context
                                    .read<HomeBloc>()
                                    .add(GetTrendingRecipesEvent());
                              } else if (categories[index] == 'Short') {
                                context
                                    .read<HomeBloc>()
                                    .add(GetShortPreparedRecipesEvent());
                              } else {
                                 context
                                    .read<HomeBloc>()
                                    .add(FetchRecipesEvent());
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: const Color(0xFFC1C1C1)),
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
                        }),
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
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is InitialState) {
                        return const Expanded(
                          child: Center(child: Text('Welcome')),
                        );
                      }
                      if (state is LoadingState) {
                        return const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (state is ErrorState) {
                        return Expanded(
                          child: Center(
                            child: Text('Error occurred: ${state.message}'),
                          ),
                        );
                      }
                      if (state is LoadedState) {
                        final List<Recipe> recipes = state.recipes;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetailsScreen(
                                                  recipe: recipes[index])));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      height: 250,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              recipes[index].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Image.asset(
                                                'assets/images/share_icon.png',
                                                height: 22,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Image.asset(
                                                    'assets/images/comment_icon.png',
                                                    height: 22,
                                                    color:
                                                        const Color(0xFFFF9B05),
                                                  ),
                                                ),
                                                TogglelikeWidget(
                                                    recipe: recipes[index]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipes[index].title,
                                              style: const TextStyle(
                                                color: Color(0xFF1E1E1E),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/time_icon.png',
                                                  height: 20,
                                                  color:
                                                      const Color(0xFFFF9B05),
                                                ),
                                                Text(
                                                  ' ${recipes[index].estimatedTime.inMinutes} min',
                                                  style: const TextStyle(
                                                    color: Color(0xFF1E1E1E),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Color(0xFFFF9B05),
                                                ),
                                                Text(
                                                  ' ${recipes[index].rate}',
                                                  style: const TextStyle(
                                                    color: Color(0xFF1E1E1E),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                              'assets/images/saved_icon.png',
                                              height: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// GestureDetector(
//                                         onTap: () {},
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadiusDirectional
//                                                     .circular(10),
//                                             color: Colors.white,
//                                           ),
//                                           width: 59,
//                                           height: 42,
//                                           child: Text(
//                                             '${recipes[index].estimatedTime.inMinutes} min',
//                                             style:
//                                                 const TextStyle(fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
