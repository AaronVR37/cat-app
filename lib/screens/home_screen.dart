import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cat_application/screens/taken_picture_screen.dart';
import 'package:cat_application/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:cat_application/helpers/database_helper.dart';
import 'package:cat_application/models/cat_model.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription firstCamera;
  final String ImagePhath;

  const HomeScreen(
      {Key? key, required this.ImagePhath, required this.firstCamera})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textControllerRace = TextEditingController();
  final textControllerFood = TextEditingController();
  int? catID;
  final textControllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Cat"),
        backgroundColor: Color.fromARGB(255, 240, 93, 240),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: textControllerName,
              decoration:
                  InputDecoration(icon: Icon(Icons.public), labelText: "Name:"),
            ),
            TextFormField(
              controller: textControllerRace,
              decoration: InputDecoration(
                  icon: Icon(Icons.description), labelText: "Race:"),
            ),
            TextFormField(
              controller: textControllerFood,
              decoration: InputDecoration(
                  icon: Icon(Icons.text_format_outlined),
                  labelText: "Alimentation:"),
            ),
            Center(
              child: (FutureBuilder<List<Cat>>(
                  future: DatabaseHelper.instance.getCats(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Cat>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("Loading"),
                        ),
                      );
                    } else {
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Container(child: const Text("No Cats")),
                            )
                          : ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.map((cat) {
                                return Center(
                                    child: ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        child: Image.file(File(cat.Image)),
                                        height: 50,
                                        width: 50,
                                      ),
                                      Container(
                                        child: Text(
                                            'Name:${cat.Name},| Race:${cat.Race},| Food:${cat.Food}'),
                                        width: 150,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      final route = MaterialPageRoute(
                                          builder: (context) =>
                                              TakenPictureScreen(
                                                camera: widget.firstCamera,
                                              ));
                                      Navigator.push(context, route);
                                      textControllerRace.text = cat.Race;
                                      textControllerFood.text = cat.Food;
                                      catID = cat.id;
                                      textControllerName.text = cat.Name;
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      DatabaseHelper.instance.delete(cat.id!);
                                    });
                                  },
                                ));
                              }).toList());
                    }
                  })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (catID != null) {
            DatabaseHelper.instance.update(Cat(
              id: catID,
              Race: textControllerRace.text,
              Food: textControllerFood.text,
              Image: widget.ImagePhath,
              Name: textControllerName.text,
            ));
          } else {
            DatabaseHelper.instance.add(Cat(
              Race: textControllerRace.text,
              Food: textControllerFood.text,
              Image: widget.ImagePhath,
              Name: textControllerName.text,
            ));
          }

          setState(() {
            textControllerName.clear();
            textControllerRace.clear();
            textControllerFood.clear();
          });
        },
      ),
    );
  }
}
