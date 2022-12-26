# Great Places
Aplicativo para selecionar seu local favorito no mapa e a foto dele

# Feature
- Aprendi a trabalhar com imagens salvando tanto local quanto o caminho no Squelite
- Para lidar com [path](https://pub.dev/packages/path) e [image](https://pub.dev/packages/image_picker) usei pacotes do próprio flutter
- Path foi usado para pegar o base nane da imagem é salvar uma imagem na memória com copy


```dart
 final appDir = await pathProvider
        .getApplicationDocumentsDirectory(); //pegando o caminho do diretorio
 final baseName =
        pathDart.basename(fileImg!.path); // pegando o nome base da imagem
 final savedImg = await fileImg?.copy('${appDir.path}/$baseName');



```

##
- Utilizei o pacote [sqflite](https://pub.dev/packages/sqflite)
- Com ele consigo criar banco com squelite no device
- Preciso retornar sempre uma nova instância do banco, se usar callback não resolve
- Por isso criei uma função para instanciar o banco e com retorno dela eu inseria ou pegava os dados
- Para lidar com formulários e, simultaneamente, validação preciso usar o onChanged e o onSubmited como exemplo abaixo

```dart
class DatabaseSquelite {

  static Future<Database> instanceDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "great.db");
    return (await openDatabase(path, version: 1,
        onCreate: (Database db, int verions) async {
      await db.execute(
          'CREATE TABLE  Places (id INTEGER PRIMARY KEY, title TEXT,file TEXT,latitude REAL,longitude REAL, address TEXT)');
    }));
  }

  static Future<void> insertValue(
      {required String nameTable, required Map<String, dynamic> data}) async {
    final database = await instanceDatabase();
    database.insert(nameTable, data);
  }

  static Future<List<Map<String, dynamic>>> returnPlaces(
      String nameTable) async {
    final database = await instanceDatabase();
    return database.query(nameTable);
  }
}


//place form
validateForm() {
    setState(() {
      enableButton = inputController.text.isNotEmpty &&
          fileImg != null &&
          location != null;
    });
  }
  
void handleSubmit() async {
    if (!enableButton) return;
    final address = await ConstantPlaceLocation.urlGeocoding(
        LatLng(location!.latitude, location!.longitude));

    Provider.of<GreatePlacesProvider>(context, listen: false).addPlace(
        title: inputController.text,
        img: fileImg!,
        longitude: location!.longitude,
        latitude: location!.latitude,
        address: address);
    Navigator.of(context).pop();
  }



 TextField(
           decoration: const InputDecoration(label: Text("Titulo")),
           controller: inputController  
           onChanged: (text) {
                    setState(() {});
                  },
                  onSubmitted: validateForm(),
          ),

```
