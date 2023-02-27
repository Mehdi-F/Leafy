import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafy/utils/palette_blue.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';
import '../models/disease_model.dart';
import '../providers/disease_provider.dart';
import '../services/classify.dart';
import '../services/hive_database.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  //static const List<Widget> _screens = [HomeScreen(), ProfileScreen(),];
  //int _selectedIndex = 0;

  late Box<Disease> _diseaseBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  void _openBox() async {
    try {
      await Hive.openBox<Disease>('plant_diseases');
      _diseaseBox = Hive.box<Disease>('plant_diseases');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Box not found. Did you forget to call Hive.openBox()?'),
      ));
    }
  }

  @override
  void dispose() {
    Hive.close();
    _pageController.dispose();
    super.dispose();
  }

  /*void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/
  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final diseaseProvider = Provider.of<DiseaseProvider>(context);
    // Hive service
    HiveService hiveService = HiveService();
    // Data
    final Classifier classifier = Classifier();
    late Disease disease;

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: <Widget>[
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentPageIndex,
          selectedItemColor: PaletteOrange.orangeToDark,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.camera_alt,
          backgroundColor: PaletteOrange.orangeToDark.shade50,
          foregroundColor: Colors.white,
          elevation: 4,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera),
              backgroundColor: PaletteOrange.orangeToDark,
              foregroundColor: Colors.white,
              label: 'Take photo',
              onTap: () async {
                double _confidence = 0.0;

                await classifier.getDisease(ImageSource.camera).then((value) {
                  disease = Disease(
                      name: value![0]["label"],
                      imagePath: classifier.imageFile.path);

                  _confidence = value[0]['confidence'];
                });
                // Check confidence
                if (_confidence > 0.5) {
                  // Set disease for Disease Service
                  diseaseProvider.setDiseaseValue(disease);
                  // Save disease
                  hiveService.addDisease(disease);
                  Navigator.restorablePushNamed(context, "/results",);
                } else {
                  // Display unsure message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('We are not sure what disease your plant has.'),
                  ));
                }
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.image),
              backgroundColor: PaletteOrange.orangeToDark,
              foregroundColor: Colors.white,
              label: 'Choose File',
              onTap: () async {
                double _confidence = 0.0;
                await classifier.getDisease(ImageSource.gallery).then((value) {
                  if (value != null && value.isNotEmpty) {
                    disease = Disease(name: value[0]["label"], imagePath: classifier.imageFile.path);
                    _confidence = value[0]['confidence'];
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('We are not sure what disease your plant has.'),
                    ));
                  }
                });
                // Check confidence
                if (_confidence > 0.5) {
                  // Set disease for Disease Service
                  diseaseProvider.setDiseaseValue(disease);
                  // Save disease
                  hiveService.addDisease(disease);
                  Navigator.restorablePushNamed(context,"/results", );
                } else {
                  // Display unsure message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('We are not sure what disease your plant has.'),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
