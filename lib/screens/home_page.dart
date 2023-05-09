// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavauto/common/card_widget.dart';

import '../common/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference services =
        FirebaseFirestore.instance.collection('services');

    return Scaffold(
      appBar: const AppBar(),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            category_widget(services: services),
            const Text(
              'Catégories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CardWidget(),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class category_widget extends StatelessWidget {
  const category_widget({
    super.key,
    required this.services,
  });

  final CollectionReference<Object?> services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: services.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        'Services',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text(
                              'See all',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/details');
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doc = snapshot.data?.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Column(children: [
                                  Image.network(doc!['image']),
                                  Text(
                                    doc['nomService'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(200);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.sort_rounded,
                  size: 30,
                ),
                color: Colors.white,
              ),
              IconButton(
                icon: const Icon(
                  Icons.supervised_user_circle_rounded,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(left: 3, bottom: 15),
            // ignore: prefer_const_constructors
            child: Text(
              "Vakloe",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                wordSpacing: 2,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search here....",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
