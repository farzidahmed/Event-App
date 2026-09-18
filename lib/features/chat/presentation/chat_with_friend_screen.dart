// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/custom_widget_pop_button.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/constants/color.dart';
import 'package:llr/features/chat/model/chat_inbox_model.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/api_access.dart';

class ChatWithFriendScreen extends StatefulWidget {
  final int? id;
  final int? roomId;
  final String name;
  final String image;

  const ChatWithFriendScreen({
    super.key,
    required this.id,
    required this.roomId,
    required this.name,
    required this.image,
  });

  @override
  State<ChatWithFriendScreen> createState() => _ChatWithFriendScreenState();
}

class _ChatWithFriendScreenState extends State<ChatWithFriendScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker picker = ImagePicker();

  PusherChannelsClient? client;
  StreamSubscription? connectionSubs;
  StreamSubscription<ChannelReadEvent>? privateChannelSubs;
  StreamSubscription? eventSubs;
  StreamSubscription? stateSubs;

  List<ChatData> messages = [];
  late String userToken;

  bool _initialLoaded = false;
  int? _currentConnectedRoomId;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasNextPage = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    userToken = appData.read(kKeyAccessToken);

    // Listen for chat data to get the correct Room ID from the server
    getChatDataRxObj.getShowProvider.listen((data) {
      if (data.data?.room?.id != null) {
        final actualRoomId = data.data!.room!.id!;
        if (_currentConnectedRoomId != actualRoomId) {
          _currentConnectedRoomId = actualRoomId;
          log("--- Received Room ID from API: $actualRoomId ---");
          connectToPusher(actualRoomId);
        }
      }
    });

    getChatDataRxObj.chatData(widget.id!);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        _hasNextPage) {
      _loadMoreMessages();
    }
  }

  Future<void> _loadMoreMessages() async {
    log("--- Loading more messages... Page: ${_currentPage + 1} ---");
    setState(() => _isLoadingMore = true);
    _currentPage++;
    await getChatDataRxObj.chatData(
      widget.id!,
    ); // Assuming your API handles page increment internally or via a param
    setState(() => _isLoadingMore = false);
  }

  @override
  void dispose() {
    connectionSubs?.cancel();
    privateChannelSubs?.cancel();
    eventSubs?.cancel();
    stateSubs?.cancel();
    client?.disconnect();
    super.dispose();
  }

  // -----------------------------------------------------------
  //                       PUSHER CONNECT
  // -----------------------------------------------------------
  void connectToPusher(int roomId) {
    // Cleanup any existing connections/subscriptions
    connectionSubs?.cancel();
    privateChannelSubs?.cancel();
    eventSubs?.cancel();
    stateSubs?.cancel();
    client?.disconnect();

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: "wss",
      host: "",
      key: "",
      port: 8081,
      shouldSupplyMetadataQueries: true,
      metadata: PusherChannelsOptionsMetadata.byDefault(),
    );

    client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) {
        log("--- Pusher Connection Error: $exception ---");
        Future.delayed(const Duration(seconds: 1), () => refresh());
      },
    );

    // 1. Log Lifecycle State Changes
    stateSubs = client!.lifecycleStream.listen((state) {
      log("--- Pusher Lifecycle State: $state ---");
    });

    // 2. Log All Events (Catch-all)
    eventSubs = client!.eventStream.listen((event) {
      log(
        "--- Pusher Event Received: [${event.name}] on channel [${event.channelName}] ---",
      );
      log("--- Event Data: ${event.data} ---");
    });

    log("--- Pusher Debug: Preparing to connect ---");
    log("--- Channel Name: private-chat-room.$roomId ---");
    log(
      "--- Token Prefix: ${userToken.length > 10 ? userToken.substring(0, 10) : userToken}... ---",
    );

    final privateChannel = client!.privateChannel(
      "private-chat-room.$roomId",
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              "",
            ),
            headers: {
              "Authorization": "Bearer $userToken",
              "Accept": "application/json",
            },
          ),
    );

    // 3. Log Private Channel Subscription Events
    privateChannel.whenSubscriptionSucceeded().listen((event) {
      log("--- Private Channel Subscription SUCCEEDED for room $roomId ---");
    });

    privateChannel.onAuthenticationSubscriptionFailed().listen((event) {
      log("--- Private Channel AUTH FAILED: ${event.data} ---");
    });

    privateChannel.onSubscriptionError().listen((event) {
      log("--- Private Channel SUBSCRIPTION ERROR: ${event.data} ---");
    });

    // 4. Log Pusher Errors
    client!.pusherErrorEventStream.listen((error) {
      log("--- Pusher ERROR Event: ${error.data} ---");
    });

    connectionSubs = client!.onConnectionEstablished.listen((_) {
      log(
        "++++++++++++++++++++++++++++++++++++++++++++++ Pusher connection established. Attempting subscription...",
      );
      privateChannel.subscribeIfNotUnsubscribed();
    });

    // Bind to the specific message event
    privateChannelSubs = privateChannel.bind("App\\Events\\MessageSendEvent").listen((
      event,
    ) {
      log(
        "============================ Message Event Triggered: ${event.name}",
      );
      final payload = json.decode(event.data);
      log("============================ New message payload: $payload");

      final newMessage = ChatData(
        senderId: payload["data"]["sender_id"],
        receiverId: payload["data"]["receiver_id"],
        text: payload["data"]["text"],
        file: payload["data"]["file"],
      );

      final currentUser = appData.read(KkuserId);
      if (newMessage.senderId != currentUser) {
        log(
          "SUCCESS: Message has been received in real-time from the other user!",
        );
      }

      setState(() => messages.insert(0, newMessage));
      _scrollToTop();
    });

    client!.connect();
  }

  void _scrollToTop() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // -----------------------------------------------------------
  //                       SEND TEXT
  // -----------------------------------------------------------
  void _sendTextMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final currentUser = appData.read(KkuserId);

    final optimistic = ChatData(
      senderId: currentUser,
      receiverId: widget.id,
      text: text,
      file: null,
    );

    setState(() => messages.insert(0, optimistic));

    _controller.clear();
    _scrollToTop();

    sendMessageRxObj.send(id: widget.id!, message: text);
  }

  // -----------------------------------------------------------
  //                     SEND IMAGE FILE
  // -----------------------------------------------------------
  Future<void> _pickImage() async {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;

    final currentUser = appData.read(KkuserId);

    final optimistic = ChatData(
      senderId: currentUser,
      receiverId: widget.id,
      text: _controller.text.isNotEmpty ? _controller.text : null,
      file: img.path,
    );

    setState(() => messages.insert(0, optimistic));
    _scrollToTop();

    sendMessageRxObj.send(
      id: widget.id!,
      message: _controller.text,
      filePath: img.path,
    );
    _controller.clear();
  }

  final TextEditingController _textController = TextEditingController();

  // -----------------------------------------------------------
  //                           UI
  // -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _header(),
      body: StreamBuilder(
        stream: getChatDataRxObj.getShowProvider,
        builder: (context, snapshot) {
          if (!_initialLoaded && snapshot.hasData) {
            final ChatInboxModel data = snapshot.data!;
            messages = List.from(data.data?.chat?.data ?? []);
            _hasNextPage =
                (data.data?.chat?.currentPage ?? 1) <
                (data.data?.chat?.lastPage ?? 1);
            _initialLoaded = true;
          } else if (snapshot.hasData && _isLoadingMore) {
            final ChatInboxModel data = snapshot.data!;
            final newMessages = data.data?.chat?.data ?? [];
            if (newMessages.isNotEmpty) {
              // Using Future.microtask to avoid setState during build
              Future.microtask(() {
                setState(() {
                  messages.addAll(newMessages);
                  _isLoadingMore = false;
                  _hasNextPage =
                      (data.data?.chat?.currentPage ?? 1) <
                      (data.data?.chat?.lastPage ?? 1);
                });
              });
            }
          }

          return Column(
            children: [Expanded(child: _messageList()), _inputBar()],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 34.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // CircleAvatar(
            //   radius: 18.r,
            //   backgroundImage: NetworkImage(widget.image),
            // ),
            CustomNetworkImage(
              urls: widget.image,
              borderRadius: 100.r,
              width: 36.w,
              height: 36.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   "Active now",
                  //   style: GoogleFonts.inter(
                  //     color: Colors.greenAccent,
                  //     fontSize: 12.sp,
                  //   ),
                  // ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              color: const Color(0xff212B36),
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onSelected: (value) {
                if (value == 'Block') {
                  blockUserRxObj.blockUser(widget.id).waitingForSucess().then((
                    success,
                  ) {
                    if (success) {
                      myAllFriendRxObj.allFriend();
                      ToastUtil.showLongToast("blocked successfully");
                    }
                  });
                } else if (value == 'Unfriend') {
                  unFriendRxObj.unFriend(widget.id).waitingForSucess().then((
                    success,
                  ) {
                    if (success) {
                      myAllFriendRxObj.allFriend();
                      ToastUtil.showLongToast("Unfriended successfully");
                    }
                  });
                } else if (value == 'Report') {
                  // reportUserRxObj
                  //     .reportUser(id: widget.id, description: "Inappropriate behavior")
                  //     .waitingForSucess()
                  //     .then((success) {
                  //       if (success) {
                  //         ToastUtil.showLongToast("User reported successfully");
                  //       }
                  //     });
                  showDialog(
                    context: context,
                    builder:
                        (context) => ActionDialog(
                          id: widget.id!,
                          onReportSuccess: () {
                            reportUserRxObj
                                .reportUser(
                                  id: widget.id,
                                  description: _textController.text,
                                )
                                .waitingForSucess()
                                .then((success) {
                                  if (success) {
                                    ToastUtil.showLongToast(
                                      "User reported successfully",
                                    );
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    _textController.clear();
                                  }
                                });
                          },
                          textController: _textController,
                        ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Block', 'Unfriend', 'Report'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageList() {
    final currentUser = appData.read(KkuserId);

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: messages.length,
      itemBuilder: (context, i) {
        final msg = messages[i];
        final bool isMe = msg.senderId == currentUser;

        return Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                CustomNetworkImage(
                  urls: widget.image,
                  borderRadius: 100.r,
                  width: 32.r,
                  height: 32.r,
                ),

              SizedBox(height: 6.h),

              if (msg.text != null) _textBubble(msg.text!, isMe),

              if (msg.file != null) _imageBubble(msg.file!, isMe),
            ],
          ),
        );
      },
    );
  }

  Widget _textBubble(String text, bool isMe) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xff20232A) : Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
          bottomLeft: isMe ? Radius.circular(12.r) : Radius.zero,
          bottomRight: isMe ? Radius.zero : Radius.circular(12.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      ),
    );
  }

  Widget _imageBubble(String filePath, bool isMe) {
    filePath.startsWith("http");

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CustomNetworkImage(
        urls: filePath,
        width: 230.w,
        height: 300.h,
        // fit: BoxFit.cover,
      ),
    );
  }

  Widget _inputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 25.h),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColor.scaffoldColor.withOpacity(0.80),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message...",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white.withOpacity(0.6),
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: _sendTextMessage,
            child: Container(
              width: 46.w,
              height: 46.h,
              decoration: BoxDecoration(
                color: const Color(0xff20232A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.send_rounded, color: Colors.white, size: 22.sp),
            ),
          ),
        ],
      ),
    );
  }
}
