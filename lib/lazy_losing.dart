import 'package:flutter/material.dart';

class LazyLosing extends StatefulWidget {
  const LazyLosing({super.key});

  @override
  State<LazyLosing> createState() => _LazyLosingState();
}

class _LazyLosingState extends State<LazyLosing> {
  final ScrollController scrollController = ScrollController();
  List<int> items = List.generate(100, (index) => index);
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        final nextItems = List.generate(20, (i) => items.length + 1);
        items.addAll(nextItems);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LAZY LOSING",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: items.length + 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            height: 60,
            width: 60,
            color: Colors.green,
            margin: EdgeInsets.only(top: 10),
            child: Center(child: Text("Items $index")),
          );
        },
      ),
    );
  }
}
