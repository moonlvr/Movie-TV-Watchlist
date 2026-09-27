import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UserSession {
  static String displayName = 'Guest';
  static String initials = 'G';
  static String? email;

  static void setCurrentUser({required String name, required String? userEmail}) {
    displayName = name.trim().isEmpty ? 'Guest' : name.trim();
    final nameParts = displayName.split(RegExp(r'\s+'));
    if (nameParts.isEmpty || nameParts.every((part) => part.isEmpty)) {
      initials = 'G';
    } else if (nameParts.length == 1) {
      initials = nameParts.first.substring(0, 1).toUpperCase();
    } else {
      initials = '${nameParts.first.substring(0, 1)}${nameParts.last.substring(0, 1)}'
          .toUpperCase();
    }
    email = userEmail;
  }

  static void clear() {
    displayName = 'Guest';
    initials = 'G';
    email = null;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _welcomeName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read the name passed via Navigator route arguments
    // (from Login or Sign-Up), per the lab requirement.
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && args.isNotEmpty) {
      _welcomeName = args;
    }
  }

  final List<Map<String, dynamic>> mediaList = [
    // --- MOVIES ---
    {
      'title': 'Interstellar',
      'type': 'Sci-Fi / Adventure',
      'category': 'Movies',
      'image': 'assets/images/interstellar.jpg',
      'status': 'Completed',
    },
    {
      'title': 'The Batman',
      'type': 'Action / Crime',
      'category': 'Movies',
      'image': 'assets/images/the_batman.jpg',
      'status': 'Watching',
    },
    {
      'title': 'Inception',
      'type': 'Sci-Fi / Action',
      'category': 'Movies',
      'image': 'assets/images/inception.jpg',
      'status': 'Completed',
    },
    {
      'title': 'Oppenheimer',
      'type': 'Biography / Drama',
      'category': 'Movies',
      'image': 'assets/images/oppenheimer.jpg',
      'status': 'Planning to Watch',
    },
    {
      'title': 'Avatar',
      'type': 'Sci-Fi / Action',
      'category': 'Movies',
      'image': 'assets/images/avatar.jpg',
      'status': 'Watching',
    },
    {
      'title': 'The Dark Knight',
      'type': 'Action / Crime',
      'category': 'Movies',
      'image': 'assets/images/the_dark_knight.jpg',
      'status': 'Completed',
    },
    {
      'title': 'Avengers: Endgame',
      'type': 'Action / Sci-Fi',
      'category': 'Movies',
      'image': 'assets/images/avengers_endgame.jpg',
      'status': 'Dropped',
    },

    // --- TV SERIES ---
    {
      'title': 'Breaking Bad',
      'type': 'Crime / Drama',
      'category': 'TV Series',
      'image': 'assets/images/breaking_bad.jpg',
      'status': 'Completed',
    },
    {
      'title': 'Stranger Things',
      'type': 'Sci-Fi / Horror',
      'category': 'TV Series',
      'image': 'assets/images/stranger_things.jpg',
      'status': 'Watching',
    },
    {
      'title': 'The Last of Us',
      'type': 'Post-Apocalyptic',
      'category': 'TV Series',
      'image': 'assets/images/the_last_of_us.jpg',
      'status': 'Planning to Watch',
    },
    {
      'title': 'Game of Thrones',
      'type': 'Action / Fantasy',
      'category': 'TV Series',
      'image': 'assets/images/game_of_thrones.jpg',
      'status': 'Dropped',
    },
    {
      'title': 'The Witcher',
      'type': 'Action / Fantasy',
      'category': 'TV Series',
      'image': 'assets/images/the_witcher.jpg',
      'status': 'Watching',
    },
    {
      'title': 'House of the Dragon',
      'type': 'Action / Fantasy',
      'category': 'TV Series',
      'image': 'assets/images/house_of_the_dragon.jpg',
      'status': 'Planning to Watch',
    },
    {
      'title': 'Better Call Saul',
      'type': 'Crime / Drama',
      'category': 'TV Series',
      'image': 'assets/images/better_call_saul.jpg',
      'status': 'Completed',
    },

    // --- ANIME ---
    {
      'title': 'One Piece',
      'type': 'Action / Adventure',
      'category': 'Anime',
      'image': 'assets/images/one_piece.jpg',
      'status': 'Watching',
    },
    {
      'title': 'Attack on Titan',
      'type': 'Dark Fantasy',
      'category': 'Anime',
      'image': 'assets/images/attack_on_titan.jpg',
      'status': 'Completed',
    },
    {
      'title': 'Jujutsu Kaisen',
      'type': 'Supernatural / Action',
      'category': 'Anime',
      'image': 'assets/images/jujutsu_kaisen.jpg',
      'status': 'Watching',
    },
    {
      'title': 'Demon Slayer',
      'type': 'Action / Fantasy',
      'category': 'Anime',
      'image': 'assets/images/demon_slayer.jpg',
      'status': 'Completed',
    },
    {
      'title': 'Naruto Shippuden',
      'type': 'Action / Adventure',
      'category': 'Anime',
      'image': 'assets/images/naruto_shippuden.jpg',
      'status': 'Dropped',
    },
    {
      'title': 'Solo Leveling',
      'type': 'Action / Fantasy',
      'category': 'Anime',
      'image': 'assets/images/solo_leveling.jpg',
      'status': 'Planning to Watch',
    },
    {
      'title': 'Bleach',
      'type': 'Action / Supernatural',
      'category': 'Anime',
      'image': 'assets/images/bleach.jpg',
      'status': 'Dropped',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Watching':
        return AppColors.statusWatching;
      case 'Completed':
        return AppColors.statusCompleted;
      case 'Dropped':
        return AppColors.statusDropped;
      case 'Planning to Watch':
      default:
        return AppColors.statusPlan;
    }
  }

  // Confirms, clears the session, and wipes the nav stack back to Login
  // so the user can't hit "back" and land in Home again.
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Log out?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'You will need to log in again to access your watchlist.',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                UserSession.clear();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
              child: const Text('Log out',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  // HELPER WIDGET FOR HORIZONTAL LISTS — responsive card sizing:
  // scales the poster width/height down on narrow (mobile) screens,
  // back to the original 180x310 size on wider screens. When every
  // card fits on screen at once, the row is centered instead of
  // left-aligned with empty space on the right.
  Widget _buildCategorySection(String categoryTitle) {
    final filteredItems = mediaList
        .where((item) => item['category'] == categoryTitle)
        .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    // Original design size was 180 wide / 310 tall (poster ratio kept).
    double cardWidth;
    if (screenWidth < 360) {
      cardWidth = 130;
    } else if (screenWidth < 600) {
      cardWidth = 150;
    } else {
      cardWidth = 180;
    }
    final posterHeight = cardWidth * (310 / 180) * 0.72; // image portion
    final textAreaHeight = 100.0; // title + genre + status box + padding
    final cardHeight = posterHeight + textAreaHeight;

    final cardMargin = 16.0;
    final horizontalPadding = 20.0;
    final totalContentWidth = (filteredItems.length * cardWidth) +
        ((filteredItems.length - 1) * cardMargin) +
        (horizontalPadding * 2);
    final fitsOnScreen = totalContentWidth <= screenWidth;

    List<Widget> buildCards() {
      return List.generate(filteredItems.length, (index) {
        final item = filteredItems[index];
        final isLast = index == filteredItems.length - 1;
        return Container(
          width: cardWidth,
          margin: EdgeInsets.only(right: isLast ? 0 : cardMargin),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: posterHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                  child: Image.asset(
                    item['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[850],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['type'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Status shown in its own gray box, next to
                    // the title/genre text (not over the poster).
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['status'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _statusColor(item['status']),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Text(
            categoryTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: fitsOnScreen
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: buildCards(),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0),
                  children: buildCards(),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/app_logo.jpg',
              height: 28,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.movie, color: Colors.red),
            ),
            const SizedBox(width: 10),
            const Text(
              'Movie/TV Watchlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          TextButton.icon(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Welcome, ${_welcomeName ?? UserSession.displayName}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildCategorySection('Movies'),
              _buildCategorySection('TV Series'),
              _buildCategorySection('Anime'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}