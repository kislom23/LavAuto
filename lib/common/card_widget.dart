// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  List<Image> images = [
    Image.asset('assets/images/suv&mono.jpg'),
    Image.asset('assets/images/citadine.jpg'),
    Image.asset('assets/images/scooooter.jpg'),
    Image.asset('assets/images/moto.jpg'),
  ];

  List<String> texts = [
    "Suv & Monospace",
    "Berline & Citadine",
    "Scooter & Tricycle",
    "Moto",
  ];

  List<String> desc = [
    "2h | Lavage complet | Intérieur/ Extérieur",
    "2h | Lavage complet | Intérieur/ Extérieur",
    "1h30 | Lavage complet",
    "30min | Lavage complet ",
  ];

  List<String> prix = [
    "3000",
    "2000",
    "1000",
    "500 ",
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });

                  Navigator.pushNamed(context, '/details', arguments: _selectedIndex);
                },
                child: Container(
                  width: 200,
                  height: 265,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: images[index],
                          height: 150,
                        ),
                        Text(
                          texts[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          desc[index],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prix[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.orange,
                              size: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
