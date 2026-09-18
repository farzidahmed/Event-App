import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/features/notification/page_not_screen.dart';

class NotificationModel {
  final String image;
  final String name;
  final String message;
  final String time;
  final bool isFriendRequest;
  final bool isToday;

  NotificationModel({
    required this.image,
    required this.name,
    required this.message,
    required this.time,
    this.isFriendRequest = false,
    this.isToday = false,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy notification list
    final notifications = [
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=1",
        name: "Emma Wilson",
        message: "liked your review of Coachella 2024",
        time: "5 min ago",
        isToday: true,
      ),
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=2",
        name: "Mike Johnson",
        message: "commented on your review of Ultra Music Festival",
        time: "1 hour ago",
        isToday: true,
      ),
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=3",
        name: "Jessi Chen",
        message: "New festival added: Electric Forest 2024",
        time: "Yesterday",
      ),
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=4",
        name: "Sophie Turner",
        message: "sent you a friend request",
        time: "Yesterday",
        isFriendRequest: true,
      ),
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=1",
        name: "Emma Wilson",
        message: "liked your review of Coachella 2024",
        time: "Yesterday",
      ),
      NotificationModel(
        image: "https://i.pravatar.cc/100?img=2",
        name: "Mike Johnson",
        message: "commented on your review of Ultra Music Festival",
        time: "Yesterday",
      ),
    ];

    // Split by Today / Yesterday
    final todayList = notifications.where((n) => n.isToday).toList();
    final yesterdayList = notifications.where((n) => !n.isToday).toList();

    return notifications.isEmpty
        ? Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D0D0D),
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Notification",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              _sectionTitle("TODAY"),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff212B36),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: List.generate(todayList.length, (index) {
                    final item = todayList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == todayList.length - 1 ? 0 : 12,
                      ),
                      child: _notificationTile(
                        image: item.image,
                        name: item.name,
                        message: item.message,
                        time: item.time,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle("YESTERDAY"),
              const SizedBox(height: 12),
              ListView.builder(
                itemCount: yesterdayList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = yesterdayList[index];
                  if (item.isFriendRequest) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _friendRequestTile(
                        image: item.image,
                        name: item.name,
                        message: item.message,
                        time: item.time,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _notificationTile(
                        image: item.image,
                        name: item.name,
                        message: item.message,
                        time: item.time,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
        : PageNotFoundScreen();
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _notificationTile({
    required String image,
    required String name,
    required String message,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 22, backgroundImage: NetworkImage(image)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$name ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: message,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _friendRequestTile({
    required String image,
    required String name,
    required String message,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 22, backgroundImage: NetworkImage(image)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$name ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: message,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B61FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Accept",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff454F5B),
                        side: BorderSide(color: Colors.grey.shade700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Decline",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
