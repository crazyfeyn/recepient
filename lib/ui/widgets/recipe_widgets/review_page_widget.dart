import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/ui/widgets/recipe_widgets/all_comments_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPageWidget extends StatefulWidget {
  const ReviewPageWidget({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPageWidget> {
  final TextEditingController _reviewController = TextEditingController();

  /// Update to store reviews with ratings
  final List<Map<String, dynamic>> _reviews = [];
  final int _truncatedLength = 300; // Qisqartirilgan uzunlik
  bool showAllReviews = false; // "See More" tugmasi holatini saqlash uchun
  int _selectedRating = 0; // Variable to store selected star rating

  void _addReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, {
          'text': _reviewController.text,
          'rating': _selectedRating,
        });
        _reviewController.clear();
        _selectedRating = 0; // Reset rating
      });
    }
  }

  void _viewAllReviews() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AllCommentsWidget(reviews: _reviews),
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
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating =
                                index + 1; // Set rating based on index
                          });
                        },
                        child: Icon(
                          index < _selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
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
              if (_reviews.isNotEmpty) // Show "See More" if there are reviews
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
        Column(
          children: List.generate(
            showAllReviews
                ? _reviews.length
                : _reviews.length > 2
                    ? 2
                    : _reviews.length,
            (index) {
              final review = _reviews[index];
              final bool isTruncated = review['text'].length > _truncatedLength;
              final String displayReview = isTruncated
                  ? review['text'].substring(0, _truncatedLength) + '...'
                  : review['text'];

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
                        displayReview,
                        maxLines: isTruncated ? 4 : null,
                        overflow: isTruncated
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                      ),
                    ),
                    const Gap(10),
                    _reviews.length > 2
                        ? const Text("")
                        : const Divider(indent: 15, endIndent: 15),
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
