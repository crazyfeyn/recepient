import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final List<String> _imageUrls = [
    "https://amiel.club/uploads/posts/2022-03/thumbs/1647740928_29-amiel-club-p-kartinki-salat-32.jpg",
    "https://cdn.bellinigroup.ru/upload/201711/5a1f9949c5f1a_1080x1080_fit.png",
    "https://sun1-26.userapi.com/impg/8hwoqz-qLXob_IMnIBRxMkeEXz7zlt1GLHZXEw/G65AZcJSDhA.jpg?size=807x807&quality=96&sign=c72118bd388acf77e3c9b48b56198c4c&c_uniq_tag=D5_IIbFkbaogi8suVxP_xS6Bypm9XmE-pp7OaZm_n90&type=album",
  ];

  int _currentIndex = 0;

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _imageUrls.length;
    });
  }

  late VideoPlayerController _controller;
  final String videoUrl = "";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: size,
                  height: 262,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_imageUrls[_currentIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 10,
                  child: IconButton(
                    onPressed: _nextImage,
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: (size / 2) - 60 / 2,
                  child: Row(
                    children: List.generate(_imageUrls.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  Text(
                    "Sausage Nasi Goreng ",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text(
                          "4.9",
                          style: GoogleFonts.montserrat(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                children: [
                  Text(
                    "21 May 2024",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  const Gap(10),
                  const Icon(
                    Icons.watch_later,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const Gap(5),
                  Text(
                    "30 Minutes",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Asian",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 90,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Indonesian",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Rice",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Oriental",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                "Ingredients",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size * 0.93,
                        height: 210,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cooked rice (preferably day-old)",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "2 cups",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sausage, sliced",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "2 pcs",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Garlic, minced",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "2 cloves",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Small onion, chopped",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "1 pc",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: (size / 2) - 65 / 2,
                  child: Row(
                    children: [
                      Text(
                        "See More",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                "How-to",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size * 0.93,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "1. Preparation (5 Minutes)",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "Cook the rice if not using leftover rice.",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "Slice the sausages, mince the garlic, chop the onion, slice the chili, and dice the carrot.",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "2. Cooking the Sausage (5 Minutes)",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "Heat 1 tablespoon of vegetable oil in a large frying pan or wok over medium-high heat.",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: (size / 2) - 65 / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "See More",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30, bottom: 10),
              child: Text(
                "How-to Videos",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size * 0.93,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        const Gap(5),
                        Text(
                          "Add to My Recipes",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size * 0.9,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.download,
                          color: Colors.grey,
                        ),
                        const Gap(5),
                        Text(
                          "Download Recipe",
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Divider(indent: 20, endIndent: 20),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size * 0.92,
                  height: 146,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "What do you think about the recipe?",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (generator) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Write a riview",
                            prefixIcon:
                                Icon(Icons.edit, color: Colors.grey[300]),
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
                bottom: 10,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews (1.262)",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "See More",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.mds.yandex.net/i?id=a917c07f6b9d1749fdc6230eb39ca844_l-5287757-images-thumbs&n=13"),
              ),
              title: Row(
                children: [
                  Text(
                    "Dayana.Parisin",
                    style: GoogleFonts.montserrat(fontSize: 13),
                  ),
                  Row(
                    children: List.generate(5, (generator) {
                      return const Icon(
                        Icons.star,
                        size: 13,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const Text("(5)"),
                ],
              ),
              subtitle: Text(
                "21 May 2024",
                style: GoogleFonts.montserrat(fontSize: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "I tried this Sausage Nasi Goreng recipe last night, and it was absolutely fantastic! The combination of flavors was spot on. The sausages added a wonderful smoky taste, and the mix of vegetables provided a nice crunch. The balance of soy sauce, oyster sauce, and sweet soy sauce gave the dish a perfect blend of savory and sweet...  "),
                  Text(
                    "See More",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const Divider(indent: 20, endIndent: 20),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.mds.yandex.net/i?id=2f932fe6d862ab09961db956fff83e2a2fa6a3d3-5210480-images-thumbs&n=13"),
              ),
              title: Row(
                children: [
                  Text(
                    "Morgot",
                    style: GoogleFonts.montserrat(fontSize: 13),
                  ),
                  Row(
                    children: List.generate(5, (generator) {
                      return const Icon(
                        Icons.star,
                        size: 13,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const Text("(5)"),
                ],
              ),
              subtitle: Text(
                "21 May 2024",
                style: GoogleFonts.montserrat(fontSize: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "I tried this Sausage Nasi Goreng recipe last night, and it was absolutely fantastic! The combination of flavors was spot on. The sausages added a wonderful smoky taste, and the mix of vegetables provided a nice crunch. The balance of soy sauce, oyster sauce, and sweet soy sauce gave the dish a perfect blend of savory and sweet...  "),
                  Text(
                    "See More",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
