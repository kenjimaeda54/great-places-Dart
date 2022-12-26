import 'package:flutter/material.dart';
import 'package:projects_dart/models/PlaceModel.dart';
import 'package:projects_dart/providers/GreatPlacesProvider.dart';
import 'package:projects_dart/utils/ConstantRoute.dart';
import 'package:provider/provider.dart';

class ListPlaceScreen extends StatelessWidget {
  const ListPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleNavigation([PlaceModel? place]) {
      if (place != null) {
        Navigator.of(context)
            .pushNamed(ConstantRoute.detailsPlace, arguments: place);
        return;
      }
      Navigator.of(context).pushNamed(ConstantRoute.placeForm);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus lugares"),
        actions: [
          IconButton(onPressed: handleNavigation, icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlacesProvider>(context, listen: false)
            .loadPlaces(),
        builder: (ctx, snapShoot) => snapShoot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlacesProvider>(
                child: const Center(child: Text("Nenhum lguar cadastrado")),
                builder: (ctx, places, ch) => places.quantityPlaces == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: places.quantityPlaces,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                places.shouldReturnPlaceByIndex(index).file),
                          ),
                          title: Text(
                              places.shouldReturnPlaceByIndex(index).title),
                          subtitle: Text(places
                                  .shouldReturnPlaceByIndex(index)
                                  .location
                                  ?.address ??
                              "Nenhum endereço"),
                          onTap: () => handleNavigation(
                              places.shouldReturnPlaceByIndex(index)),
                        ),
                      ),
              ),
      ),
    );
  }
}
