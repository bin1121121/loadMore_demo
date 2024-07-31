import 'package:flutter/material.dart';
import 'package:loadmore_demo/controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Controller>(context, listen: false).onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Controller>(builder: (context, controller, child) {
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error));
        }
        return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.posts.length + 1,
          itemBuilder: (context, index) {
            if (index < controller.posts.length) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(controller.posts[index].id.toString()),
                  ),
                  title: Text(controller.posts[index].title),
                  subtitle: Text(controller.posts[index].body),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
    );
  }
}
