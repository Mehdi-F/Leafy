import 'package:flutter/material.dart';

import '../models/disease_model.dart';

class DiseaseProvider with ChangeNotifier {
  late Disease _disease;

  Disease get disease => _disease;

  void setDiseaseValue(Disease disease) {
    _disease = disease;
    notifyListeners();
  }
}
