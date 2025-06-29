import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> moods = [
    "Happy", "Sad", "Stressed", "Motivated",
    "Relaxed", "Anxious", "Excited", "Tired"
  ];

  final Map<String, List<String>> quotes = {
    "Happy": [
      "Happiness is a direction, not a place.",
      "Smile, it's free therapy.",
      "Happiness blooms from within.",
      "Joy is contagious, spread it!",
      "Collect beautiful moments.",
      "Choose happiness every day.",
      "Sunshine mixed with a little hurricane.",
      "Happiness is homemade.",
      "Find joy in the ordinary.",
      "Let your smile change the world."
    ],
    "Sad": [
      "Stars can't shine without darkness.",
      "Tough times never last.",
      "Sadness flies away on the wings of time.",
      "Tears are words the heart can't express.",
      "Every storm runs out of rain.",
      "Crying is how your heart speaks.",
      "It's okay to not be okay.",
      "Healing takes time.",
      "Turn your wounds into wisdom.",
      "Sadness is but a wall between two gardens."
    ],
    "Stressed": [
      "Breathe. It's just a bad day, not a bad life.",
      "One thing at a time.",
      "This too shall pass.",
      "Don't stress over what you can't control.",
      "Take a deep breath and let it go.",
      "Your mind will always believe everything you tell it.",
      "Release the need to control.",
      "Pause. Rest. Reset.",
      "Stay positive, work hard, make it happen.",
      "Turn your stress into strength."
    ],
    "Motivated": [
      "Push yourself, because no one else will do it for you.",
      "Dream big, work hard.",
      "Stay hungry. Stay foolish.",
      "Doubt kills more dreams than failure.",
      "Success is the sum of small efforts.",
      "Believe you can and you're halfway there.",
      "The harder you work, the luckier you get.",
      "Make it happen. Shock everyone.",
      "Keep going. No excuses.",
      "Your only limit is you."
    ],
    "Relaxed": [
      "Peace begins with a smile.",
      "Inhale peace, exhale stress.",
      "Relax. Refresh. Recharge.",
      "Be like a tree, stay grounded.",
      "Slow down and everything you are chasing will come around.",
      "Take it easy.",
      "Nothing is worth stressing over.",
      "Find your calm.",
      "Serenity is not freedom from the storm, but peace amid the storm.",
      "Let go and relax."
    ],
    "Anxious": [
      "You have survived 100% of your worst days.",
      "Trust the process.",
      "Feelings are just visitors, let them come and go.",
      "Anxiety does not define you.",
      "Be gentle with yourself.",
      "One step at a time.",
      "This feeling is temporary.",
      "Calm mind brings inner strength.",
      "Overthinking leads to sadness, take action.",
      "Let it be."
    ],
    "Excited": [
      "The best is yet to come!",
      "Excitement is contagious.",
      "Every day is a new adventure.",
      "Follow your excitement.",
      "Life is either a daring adventure or nothing.",
      "Good things are coming!",
      "Fuel your passion.",
      "Be fearless in the pursuit of what sets your soul on fire.",
      "Jump in with both feet.",
      "Let your excitement guide you."
    ],
    "Tired": [
      "Rest is productive too.",
      "Listen to your body.",
      "Even the sun needs to set to rise again.",
      "Take a break, not a quit.",
      "Fatigue is the best pillow.",
      "Energy flows where attention goes.",
      "You deserve to rest.",
      "Slow down before life forces you to.",
      "Recharge. Refocus. Restart.",
      "Self-care is how you take your power back."
    ],
  };

  final Map<String, Color> pastelColors = {
    "Happy": Color(0xFFFFF4CC),
    "Sad": Color(0xFFCCE5FF),
    "Stressed": Color(0xFFFFCCCC),
    "Motivated": Color(0xFFD4F1BE),
    "Relaxed": Color(0xFFE0BBE4),
    "Anxious": Color(0xFFFFDAB9),
    "Excited": Color(0xFFFFF0F5),
    "Tired": Color(0xFFC1E1C1),
  };

  List<GlobalKey<FlipCardState>> cardKeys = [];
  Map<String, String> currentQuotes = {};

  @override
  void initState() {
    super.initState();
    cardKeys = List.generate(moods.length, (index) => GlobalKey<FlipCardState>());
    moods.forEach((mood) {
      currentQuotes[mood] = getRandomQuote(mood);
    });
  }

  String getRandomQuote(String mood) {
    final random = Random();
    final quotesList = quotes[mood] ?? [];
    if (quotesList.isNotEmpty) {
      return quotesList[random.nextInt(quotesList.length)];
    }
    return '';
  }

  void flipCard(int index, String mood) {
    for (int i = 0; i < cardKeys.length; i++) {
      if (i != index && cardKeys[i].currentState?.isFront == false) {
        cardKeys[i].currentState?.toggleCard();
      }
    }
    setState(() {
      currentQuotes[mood] = getRandomQuote(mood);
    });
  }

  void flipBackAllCards() {
    for (var key in cardKeys) {
      if (key.currentState?.isFront == false) {
        key.currentState?.toggleCard();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 4; // 📱 2 columns on phones, 🖥️ 4 columns on large screens
    double cardSpacing = 10;
    double cardWidth = (screenWidth - (cardSpacing * (crossAxisCount + 1))) / crossAxisCount;
    double cardHeight = cardWidth;

    return GestureDetector(
      onTap: flipBackAllCards,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Your Mood'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: GridView.builder(
          physics: BouncingScrollPhysics(),  // Enables smooth scrolling
          padding: const EdgeInsets.all(8.0),
          itemCount: moods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: cardSpacing,
            mainAxisSpacing: cardSpacing,
            childAspectRatio: cardWidth / cardHeight,
          ),
          itemBuilder: (context, index) {
            final mood = moods[index];
            final pastelColor = pastelColors[mood] ?? Colors.grey.shade200;
            return FlipCard(
              key: cardKeys[index],
              flipOnTouch: true,
              onFlip: () => flipCard(index, mood),
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                decoration: BoxDecoration(
                  color: pastelColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    mood,
                    style: TextStyle(
                      fontSize: cardWidth * 0.12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              back: GestureDetector(
                onTap: () => flipCard(index, mood),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: pastelColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentQuotes[mood] ?? '',
                        style: TextStyle(
                          fontSize: cardWidth * 0.09,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
