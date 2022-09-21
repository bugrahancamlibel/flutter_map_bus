import 'package:flutter/material.dart';
import 'package:flutter_map_bus/models/user_town_provider.dart';
import 'package:flutter_map_bus/screens/admin_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../models/user_model.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     User user = User(id: 2, name: "flutter", password: "1234");
     var db = DatabaseHelper.instance;
     db.add(user);
    final travelers = ref.read(townProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("ADMIN PANEL"),
      ),
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SeeUsersScreen()),
                );
              },
              child: const Card(
                color: Colors.white54,
                child: ListTile(
                  leading: Text("All students"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TravelersCountsScreen()),
                );
              },
              child: const Card(
                color: Colors.white54,
                child: ListTile(
                  leading: Text("Travelers Counts List"),
                ),
              ),
            ),
            /*GestureDetector(
              onTap: () {
                if(travelers.getTravelers().toString() == "{}"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TravelersCountsScreen()),
                  );
                }
                else{
                  print(travelers.getTravelers());
                  //TODO: algorithm will work in this time.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminMapView()),
                  );
                }
              },
              child: const Card(
                color: Colors.white54,
                child: ListTile(
                  leading: Text("See the routes"),
                ),
              ),
            ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Maps(travelers.getTravelers())),
                );
              },
              child: const Card(
                color: Colors.white54,
                child: ListTile(
                  leading: Text("See the all the routes"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeeUsersScreen extends ConsumerWidget {
  const SeeUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("All Users"),
      ),
      body: FutureBuilder<List<User>>(
          future: DatabaseHelper.instance.getUser(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Couldn't load anything"),
              );
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('No users in list'),
                  )
                : ListView(
                    children: snapshot.data!.map((user) {
                      return Center(
                        child: Card(
                          color: Colors.teal,
                          child: ListTile(
                            title: Text("Username: ${user.name}",
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text("Password: ${user.password}",
                                style: const TextStyle(color: Colors.white)),
                            trailing: Text("ID: ${user.id}",
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    }).toList(),
                  );
          }),
    );
  }
}

class TravelersCountsScreen extends ConsumerWidget {
  const TravelersCountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var basiskeleController = TextEditingController();
    var cayirovaController = TextEditingController();
    var daricaController = TextEditingController();
    var derinceController = TextEditingController();
    var dilovasiController = TextEditingController();
    var gebzeController = TextEditingController();
    var golcukController = TextEditingController();
    var kandiraController = TextEditingController();
    var karamurselController = TextEditingController();
    var kartepeController = TextEditingController();
    var korfezController = TextEditingController();
    var izmitController = TextEditingController();

    final travelers = ref.read(townProvider.notifier);


    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text("Student Counts"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Map<String, int> townCounts = {
              'Başiskele': int.parse(basiskeleController.text),
              "Çayırova": int.parse(cayirovaController.text),
              "Darıca": int.parse(daricaController.text),
              "Derince": int.parse(derinceController.text),
              "Dilovası": int.parse(dilovasiController.text),
              "Gebze": int.parse(gebzeController.text),
              "Gölcük": int.parse(golcukController.text),
              "Kandıra": int.parse(kandiraController.text),
              "Karamürsel": int.parse(karamurselController.text),
              "Kartepe": int.parse(kartepeController.text),
              "Körfez": int.parse(korfezController.text),
              "İzmit": int.parse(izmitController.text)
            };
            travelers.setCurrentTown(townCounts);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyApp()),
            );
          },
          child: const Icon(Icons.save),
          splashColor: Colors.amber,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          children: [
            buildTile("Başiskele", basiskeleController),
            buildTile("Çayırova", cayirovaController),
            buildTile("Darıca", daricaController),
            buildTile("Derince", derinceController),
            buildTile("Dilovası", dilovasiController),
            buildTile("Gebze", gebzeController),
            buildTile("Gölcük", golcukController),
            buildTile("Kandıra", kandiraController),
            buildTile("Karamürsel", karamurselController),
            buildTile("Kartepe", kartepeController),
            buildTile("Körfez", korfezController),
            buildTile("İzmit", izmitController),
          ],
        ));
  }

  Card buildTile(title, controller) {
    return Card(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 5, bottom: 5),
      child: ListTile(
        tileColor: Colors.amber,
        title: Text(title.toString()),
        leading: const Icon(Icons.navigate_next),
        trailing: SizedBox(
          width: 30,
          height: 40,
          child: TextField(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
