import 'package:flutter/material.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}
final textController=TextEditingController();
class _ContainerScreenState extends State<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.construction),
                    ),
                    trailing: const Column(
                      children: [
                        Text("10.000"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("10.000")
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width/1.3,
                        child: TextField(
                          maxLines: null,
                          controller:textController ,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.shuffle),
                            hintText: "Places"
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
