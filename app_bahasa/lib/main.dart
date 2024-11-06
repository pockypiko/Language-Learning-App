import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar bookmark yang dipilih pengguna
  List<Map<String, String>> bookmarkedLessons = [];

  // Apakah saat ini di tab "Today" atau "Learning plan"
  bool isLearningPlanTab = false;

  void toggleBookmark(Map<String, String> lesson) {
    setState(() {
      if (bookmarkedLessons.contains(lesson)) {
        bookmarkedLessons.remove(lesson);
      } else {
        bookmarkedLessons.add(lesson);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/profile.png'), // tambahkan gambar profil Anda di sini
            ),
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.grey),
                SizedBox(width: 16),
                Icon(Icons.settings, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello 👋',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Dafavico Assechan', // Ganti dengan nama pengguna dinamis jika diperlukan
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton(context, "Today", !isLearningPlanTab),
                _buildTabButton(context, "Learning plan", isLearningPlanTab),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: isLearningPlanTab
                    ? bookmarkedLessons
                        .map((lesson) => LessonCard(
                              title: lesson['title']!,
                              subtitle: lesson['subtitle']!,
                              imageUrl: lesson['imageUrl']!,
                              isBookmarked: true,
                              onBookmarkToggle: () => toggleBookmark(lesson),
                            ))
                        .toList()
                    : [
                        LessonCard(
                          title: "Lesson 1",
                          subtitle: "SpeakClass -beta",
                          imageUrl: 'assets/instructor1.jpg',
                          isBookmarked: bookmarkedLessons.contains({
                            'title': "Lesson 1",
                            'subtitle': "SpeakClass -beta",
                            'imageUrl': 'assets/instructor1.jpg',
                          }),
                          onBookmarkToggle: () => toggleBookmark({
                            'title': "Lesson 1",
                            'subtitle': "SpeakClass -beta",
                            'imageUrl': 'assets/instructor1.jpg',
                          }),
                        ),
                        LessonCard(
                          title: "Lesson 12",
                          subtitle: "Lesson continue",
                          imageUrl: 'assets/instructor2.jpg',
                          isBookmarked: bookmarkedLessons.contains({
                            'title': "Lesson 12",
                            'subtitle': "Lesson continue",
                            'imageUrl': 'assets/instructor2.jpg',
                          }),
                          onBookmarkToggle: () => toggleBookmark({
                            'title': "Lesson 12",
                            'subtitle': "Lesson continue",
                            'imageUrl': 'assets/instructor2.jpg',
                          }),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLearningPlanTab = (text == "Learning plan");
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.black,
            width: 8,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const LessonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isBookmarked = false,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Start lesson'),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? Colors.yellow : Colors.white,
                  ),
                  onPressed: onBookmarkToggle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
