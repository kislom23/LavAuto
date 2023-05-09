// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';

import '../../common/component/checkbos_state.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<String> imagePaths = [
    'assets/images/suv&mono.jpg',
    'assets/images/citadine.jpg',
    'assets/images/scooooter.jpg',
    'assets/images/moto.jpg',
  ];

  List<AssetImage> images = [];

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

  final options = [
    CheckBoxState(title: 'Poils d\'animaux | 500 Fr'),
    CheckBoxState(title: 'intérieur très sale | 500 Fr'),
    CheckBoxState(title: 'Shampoing coffre | 500 Fr'),
    CheckBoxState(title: 'Shampoing siège | 500 Fr'),
  ];

  @override
  Widget build(BuildContext context) {
    for (String imagePath in imagePaths) {
      images.add(AssetImage(imagePath));
    }

    final int selectedIndex = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child: Image(
                  image: images[selectedIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
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
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            texts[selectedIndex],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            desc[selectedIndex],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 8,
                            color: Color.fromARGB(255, 180, 94, 7),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Notre formule comprend un lavage complet, de fond en comble, puis l'application d'une cire de protection et brillance, ainsi que d'un produit de brillance des pneus.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 8,
                            color: Color.fromARGB(255, 180, 94, 7),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Options",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Expanded(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                ...options.map(buildSingleCheckbox).toList(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(327, 50),
                                backgroundColor: Colors.orange,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Suivant",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.orangeAccent,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontSize: 14),
        ),
        onChanged: (value) => setState(() => checkbox.value = value!),
      );
}
