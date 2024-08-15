// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/logic/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TogglelikeWidget extends StatefulWidget {
  final Recipe recipe;
  const TogglelikeWidget({super.key, required this.recipe});

  @override
  State<TogglelikeWidget> createState() => _TogglelikeWidgetState();
}

class _TogglelikeWidgetState extends State<TogglelikeWidget> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.recipe.likes.contains('-O4HZBl8WZ1K8zv0Pj2E');
    likeCount = widget.recipe.likes.length;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });

    context
        .read<HomeBloc>()
        .add(ToggleLikeEvent('9SjFRAq9AJSIqIshJmFA1kAHtjr1', widget.recipe.id));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          color: Colors.white,
        ),
        width: 59,
        height: 42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              color: const Color(0xFFFF9B05),
              size: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                likeCount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
