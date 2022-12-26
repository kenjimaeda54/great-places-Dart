import 'dart:io';
import "package:flutter/material.dart";
import "package:path/path.dart" as pathDart;
import "package:path_provider/path_provider.dart" as pathProvider;
import 'package:image_picker/image_picker.dart';

class PreviewImageWidget extends StatefulWidget {
  Function(File img) onSelecteImg;
  PreviewImageWidget(this.onSelecteImg, {Key? key}) : super(key: key);

  @override
  State<PreviewImageWidget> createState() => _PreviewImageWidgetState();
}

class _PreviewImageWidgetState extends State<PreviewImageWidget> {
  File? fileImg;

  _takePickture() async {
    final imagePicker = ImagePicker();
    XFile? response =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (response == null) return;

    setState(() {
      fileImg = File(response.path);
    });
    final appDir = await pathProvider
        .getApplicationDocumentsDirectory(); //pegando o caminho do diretorio
    final baseName =
        pathDart.basename(fileImg!.path); // pegando o nome base da imagem
    final savedImg = await fileImg?.copy('${appDir.path}/$baseName');

    widget.onSelecteImg(savedImg!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1)),
          child: fileImg != null
              ? Image.file(fileImg!, width: double.infinity, fit: BoxFit.cover)
              : const Text(
                  "Nenhuma imagem",
                  textAlign: TextAlign.center,
                ),
        ),
        Expanded(
          child: TextButton(
              onPressed: _takePickture,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera),
                  SizedBox(width: 10),
                  Text("Tirar foto")
                ],
              )),
        )
      ],
    );
  }
}
