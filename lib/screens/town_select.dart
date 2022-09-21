import 'package:flutter/material.dart';
import 'package:flutter_map_bus/screens/user_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/user_model.dart';
import 'package:flutter_map_bus/models/user_town_provider.dart';

class TownSelectScreen extends ConsumerWidget {
  const TownSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final travelers = ref.read(townProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Pick a town"),
      ),
      body: auth == null ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(auth == null ? "Username and password are not matching" : auth.name),
            ElevatedButton(
              child: const Text("Go Back"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ) :  Center(
        child: ListView(
          children: [
            buildTile(travelers, context, "Başiskele"),
            buildTile(travelers, context, "Çayırova"),
            buildTile(travelers, context, "Darıca"),
            buildTile(travelers, context, "Derince"),
            buildTile(travelers, context, "Dilovası"),
            buildTile(travelers, context, "Gebze"),
            buildTile(travelers, context, "Gölcük"),
            buildTile(travelers, context, "Kandıra"),
            buildTile(travelers, context, "Karamürsel"),
            buildTile(travelers, context, "Kartepe"),
            buildTile(travelers, context, "Körfez"),
            buildTile(travelers, context, "İzmit"),
          ],
        ),
      ),
    );
  }
  Card buildTile(travelers, context, title) {
    return Card(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 5),
      child: ListTile(
        onTap: (){
          print("ne gelicek");
          print(travelers.getTravelers()[title.toString()]);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserMap(title),
            ),
          );
        },
        title: Text(
          title.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
        leading: const Icon(Icons.navigate_next,color: Colors.white),
        trailing: const Icon(Icons.location_pin, color: Colors.white),
        tileColor: Colors.deepPurple,
      ),
    );
  }
}
