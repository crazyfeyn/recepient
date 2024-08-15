import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCommentsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const AllCommentsWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Comments'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];

          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://avatars.mds.yandex.net/i?id=a917c07f6b9d1749fdc6230eb39ca844_l-5287757-images-thumbs&n=13"),
                  ),
                  title: Row(
                    children: [
                      Text(
                        "User",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 13,
                            color: index < review['rating']
                                ? Colors.amber
                                : Colors.grey,
                          );
                        }),
                      ),
                      Text("(${review['rating']})"),
                    ],
                  ),
                  subtitle: Text(
                    "21 May 2024",
                    style: GoogleFonts.montserrat(fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8.0),
                  child: Text(
                    review['text'],
                  ),
                ),
                const Gap(10),
                const Divider(indent: 15, endIndent: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
