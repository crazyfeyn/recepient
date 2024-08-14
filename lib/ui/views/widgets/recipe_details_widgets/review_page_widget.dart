import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/widgets/recipe_details_widgets/all_comments_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPageWidget extends StatefulWidget {
  const ReviewPageWidget({super.key});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPageWidget> {
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _reviews = [];
  final int _truncatedLength = 300;

  void _addReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, _reviewController.text);
        _reviewController.clear();
      });
    }
  }

  void _viewAllReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllReviewsPage(reviews: _reviews),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            width: double.infinity,
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
                    (index) {
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
                    controller: _reviewController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Write a review",
                      prefixIcon: Icon(Icons.edit, color: Colors.grey[300]),
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    onFieldSubmitted: (value) => _addReview(),
                  ),
                ),
              ],
            ),
          ),
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
                "Reviews (${_reviews.length})",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              if (_reviews.length > 0) // Show "See More" if there are reviews
                GestureDetector(
                  onTap: _viewAllReviews,
                  child: Text(
                    "See More",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.amber,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              final review = _reviews[index];
              final bool isTruncated = review.length > _truncatedLength;

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
                      padding: const EdgeInsets.only(left: 15, top: 8.0),
                      child: Text(
                        isTruncated
                            ? review.substring(0, _truncatedLength) + '...'
                            : review,
                        maxLines: isTruncated ? 4 : null,
                        overflow: isTruncated
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                      ),
                    ),
                    const Gap(10),
                    const Divider(indent: 15, endIndent: 15),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
