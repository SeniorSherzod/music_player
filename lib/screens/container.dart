import 'package:flutter/material.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notification_add))
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            Container(
              // margin: BorderRadius.vertical(top: Radius.circular(radius)),
              // padding: EdgeInsets.vertical(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
              child: ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.construction),
                ),
                trailing: Column(
                  children: [
                    Text("10.000"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("10.000")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
