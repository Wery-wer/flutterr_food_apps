import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final Function(int) onRatingChanged; // Callback function

  const RatingStars({super.key, required this.onRatingChanged});
  
  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int rating = 0;

  void updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });

    widget.onRatingChanged(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            updateRating(index + 1);
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
        );
      }),
    );
  }
}

