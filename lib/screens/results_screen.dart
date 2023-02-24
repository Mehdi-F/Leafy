import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leafy/providers/disease_provider.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';

import '../models/disease_model.dart';
import '../utils/palette_blue.dart';
import '../utils/plant_image.dart';
import '../utils/results_text.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _diseaseService = Provider.of<DiseaseProvider>(context);

    Disease _disease = _diseaseService.disease;
    return Scaffold(
      appBar: AppBar(
        title: Text("Results",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Colors.white),
        ),
        backgroundColor: PaletteBlue.blueToDark.shade200,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Flexible(
                  child: Center(
                      child: PlantImage(
                        size:  MediaQuery.of(context).size,
                        imageFile: File(_disease.imagePath),
                      )
                  )
              ),
              Divider(
                thickness: (0.0066 *  MediaQuery.of(context).size.height),
                height: (0.013 *  MediaQuery.of(context).size.height),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  children: [
                    TextWidget(
                      title: 'Disease name',
                      value: _disease.name,
                      height: 24,
                      weight: FontWeight.w500,
                    ),
                    TextWidget(
                      title: 'Possible causes',
                      value: _disease.possibleCauses,
                      height: 20,
                      weight: FontWeight.w500,
                    ),
                    TextWidget(
                      title: 'Possible solution',
                      value: _disease.possibleSolution,
                      height: 20,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
