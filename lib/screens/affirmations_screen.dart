import 'package:flutter/material.dart';

class AffirmationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> affirmations = [
    {"text": "I am capable.", "color": Colors.pink.shade100},
    {"text": "I believe in myself.", "color": Colors.blue.shade100},
    {"text": "I am worthy.", "color": Colors.green.shade100},
    {"text": "I choose happiness.", "color": Colors.yellow.shade100},
    {"text": "I am strong.", "color": Colors.purple.shade100},
    {"text": "I trust my journey.", "color": Colors.orange.shade100},
    {"text": "I radiate positivity.", "color": Colors.teal.shade100},
    {"text": "I am fearless.", "color": Colors.lime.shade100},
    {"text": "I embrace growth.", "color": Colors.cyan.shade100},
    {"text": "I am grateful.", "color": Colors.indigo.shade100},
    {"text": "I am evolving.", "color": Colors.red.shade100},
    {"text": "I attract abundance.", "color": Colors.amber.shade100},
    {"text": "I am confident.", "color": Colors.lightGreen.shade100},
    {"text": "I am loved.", "color": Colors.deepPurple.shade100},
    {"text": "I am focused.", "color": Colors.brown.shade100},
    {"text": "I am joyful.", "color": Colors.deepOrange.shade100},
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width to determine number of columns
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 4; // 2 columns on small screens, 4 on larger screens
    double cardSpacing = 10;
    double cardWidth = (screenWidth - (cardSpacing * (crossAxisCount + 1))) / crossAxisCount;
    double cardHeight = cardWidth;

    // Calculate dynamic font size
    double textSize = screenWidth < 600 ? 14 : 16; // 14 on small screens, 16 on large screens

    return Scaffold(
      appBar: AppBar(
        title: Text('Affirmations'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          // Internal scrollable GridView
          shrinkWrap: true, // Shrink wrap to fit the content
          physics: AlwaysScrollableScrollPhysics(), // Always allow scrolling inside GridView
          itemCount: affirmations.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Adjust columns based on screen size
            crossAxisSpacing: cardSpacing,
            mainAxisSpacing: cardSpacing,
            childAspectRatio: cardWidth / cardHeight,
          ),
          itemBuilder: (context, index) {
            final affirmation = affirmations[index];
            return Container(
              decoration: BoxDecoration(
                color: affirmation['color'],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    affirmation['text'],
                    style: TextStyle(
                      fontSize: textSize, // Adjusted font size dynamically
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
