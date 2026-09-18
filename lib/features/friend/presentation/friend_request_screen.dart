import 'package:flutter/material.dart';


class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const FriendRequestsPage(),
    );
  }
}

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingRequests = [
      {
        "name": "Sophie Turner",
        "time": "Yesterday",
        "image": "https://randomuser.me/api/portraits/women/45.jpg"
      },
      {
        "name": "Ryan Martinez",
        "time": "Yesterday",
        "image": "https://randomuser.me/api/portraits/men/46.jpg"
      },
      {
        "name": "Sophie Turner",
        "time": "Yesterday",
        "image": "https://randomuser.me/api/portraits/women/47.jpg"
      },
    ];

    final peopleYouMayKnow = [
      {
        "name": "Sophie Turner",
        "image": "https://randomuser.me/api/portraits/women/48.jpg"
      },
      {
        "name": "Sophie Turner",
        "image": "https://randomuser.me/api/portraits/women/49.jpg"
      },
      {
        "name": "David Kim",
        "image": "https://randomuser.me/api/portraits/men/50.jpg"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "Friend Requests",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pending Requests
              Text(
                "Pending Requests (${pendingRequests.length})",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              Column(
                children: pendingRequests
                    .map((friend) => PendingRequestCard(
                          name: friend["name"]!,
                          time: friend["time"]!,
                          imageUrl: friend["image"]!,
                        ))
                    .toList(),
              ),

              const SizedBox(height: 24),

              // People You May Know
              const Text(
                "People You May Know",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              Column(
                children: peopleYouMayKnow
                    .map((friend) => PeopleYouMayKnowCard(
                          name: friend["name"]!,
                          imageUrl: friend["image"]!,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔷 Custom Widget for Pending Requests
class PendingRequestCard extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;

  const PendingRequestCard({
    super.key,
    required this.name,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                ),
                child: const Text("Accept",
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text("Decline",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🟣 Custom Widget for “People You May Know”
class PeopleYouMayKnowCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const PeopleYouMayKnowCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            ),
            child: const Text(
              "Add Friend",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
