import 'package:hive/hive.dart';

part 'disease_model.g.dart';

@HiveType(typeId: 0)
class Disease extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  late String possibleCauses;

  @HiveField(2)
  late String possibleSolution;

  @HiveField(3)
  late String imagePath;

  @HiveField(4)
  late DateTime dateTime;

  Disease({required this.name, required this.imagePath}) {
    dateTime = DateTime.now();

    switch (name) {
      case "Apple Scab":
        possibleCauses =
        "Caused by the fungus Venturia inaequalis, which overwinters in infected leaves on the ground.";
        possibleSolution =
        "Fungicide treatments. Should be applied preventatively before the disease takes hold.";
        break;

      case "Apple Black rot":
        possibleCauses =
        "Caused by the fungus Botryosphaeria obtusa and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Fungicide treatments: Fungicides can be effective in controlling apple black rot, but they should be applied preventatively and at the first signs of the disease. Different fungicides have different application schedules, so it's important to follow the label instructions carefully.";
        break;

      case "Apple Cedar apple rust":
        possibleCauses =
        "Caused by the fungus Gymnosporangium juniperi-virginianae and requires two hosts to complete its life cycle: apple and Eastern red cedar trees.";
        possibleSolution =
        "Control of alternate host: Eastern red cedar is the alternate host of cedar apple rust, so removing these trees or reducing their number can help to break the disease cycle and reduce the risk of infection.";
        break;

      case "Apple healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Blueberry healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Cherry healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Cherry Powdery mildew":
        possibleCauses =
        "Caused by the fungus Podosphaera clandestina and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Fungicide treatments: Fungicides can be effective in controlling cherry powdery mildew, but they should be applied preventatively and at the first signs of the disease.";
        break;

      case "Corn Cercospora leaf spot Gray leaf spot":
        possibleCauses =
        "Caused by the fungus Cercospora zeae-maydis and is characterized by the appearance of small, oval, brown lesions on the leaves of the plant. Gray leaf spot is caused by the fungus Cercospora zeina and is characterized by the appearance of long, narrow, gray lesions on the leaves of the plant.";
        possibleSolution =
        "Good cultural practices, such as proper crop rotation, tillage, and irrigation, can help to maintain plant health and reduce the risk of both diseases. Removing crop residue and debris after harvest can also help to prevent the spread of the diseases.";
        break;

      case "Corn Common rust":
        possibleCauses =
        "by the fungus Puccinia sorghi and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Plant disease-resistant varieties: Some corn varieties are resistant or tolerant to common rust, and planting these varieties can help prevent or reduce the severity of the disease.";
        break;

      case "Corn healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Corn Northern Leaf Blight":
        possibleCauses =
        "Caused by the fungus Exserohilum turcicum and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Good cultural practices: Good cultural practices, such as proper crop rotation, tillage, and irrigation, can help to maintain plant health and reduce the risk of northern corn leaf blight. Removing crop residue and debris after harvest can also help to prevent the spread of the disease.";
        break;

      case "Grape Black rot":
        possibleCauses =
        "Caused by the fungus Guignardia bidwellii, which infects the fruit and leaves of the plant and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Fungicide treatments: Fungicides can be effective in controlling grape black rot, but they should be applied preventatively and at the first signs of the disease.";
        break;

      case "Grape Esca (Black Measles)":
        possibleCauses =
        "Caused by a complex of fungi, including Phaeomoniella chlamydospora and Phaeoacremonium aleophilum, which infect the wood of the vine and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Use of biofungicides: Biofungicides, such as Bacillus subtilis or Bacillus amyloliquefaciens, can be effective in controlling grape Esca.";
        break;

      case "Grape healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Grape Leaf blight (Isariopsis Leaf Spot)":
        possibleCauses =
        "Caused by the fungus Isariopsis griseola, which infects the leaves of the plant and can cause significant damage to the crop if left untreated.";
        possibleSolution =
        "Use of biofungicides: Biofungicides, such as Bacillus subtilis or Bacillus amyloliquefaciens, can be effective in controlling grape leaf blight.";
        break;

      case "Orange Haunglongbing (Citrus greening)":
        possibleCauses =
        "Caused by the bacterium Candidatus Liberibacter asiaticus, which is spread by the Asian citrus psyllid insect.";
        possibleSolution =
        "Plant disease-free stock: Planting disease-free citrus trees is important to prevent the introduction of the bacterium into a citrus grove.";
        break;

      case "Peach Bacterial spot":
        possibleCauses =
        "Caused by the bacterium Xanthomonas arboricola pv. pruni, that affects peach and nectarine trees.";
        possibleSolution =
        "Plant disease-resistant varieties. Monitor plants regularly. Copper fungicides. ";
        break;

      case "Peach healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Pepper Bell Bacterial Spot":
        possibleCauses =
        "Caused by Xanthomonas bacteria, spread through splashing rain.";
        possibleSolution =
        "Spray early and often. Use copper and Mancozeb sprays.";
        break;

      case "Pepper Bell Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Potato Early Blight":
        possibleCauses =
        "The fungus Alternaria solani, high humidity and long periods of leaf wetness.";
        possibleSolution =
        "Maintaining optimum growing conditions: proper fertilization, irrigation, and pests management.";
        break;

      case "Potato Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Potato Late Blight":
        possibleCauses =
        "Occurs in humid regions with temperatures ranging between 4 and 29 °C.";
        possibleSolution =
        "Eliminating cull piles and volunteer potatoes, using proper harvesting and storage practices, and applying fungicides when necessary.";
        break;

      case "Raspberry Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Soybean Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Squash Powdery mildew":
        possibleCauses =
        "Podosphaera xanthii fungus which infects the leaves, stems, and fruit of squash plants. The disease is more prevalent in warm, humid conditions and can spread rapidly in crowded, poorly ventilated conditions.";
        possibleSolution =
        "Plant resistant varieties: Some squash varieties are resistant to powdery mildew, and planting these varieties can help prevent or reduce the severity of the disease.";
        break;

      case "Strawberry Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Strawberry Leaf scorch":
        possibleCauses =
        "Xylella fastidiosa bacterium which is transmitted by leafhoppers and other sap-feeding insects.";
        possibleSolution =
        "Plant disease-resistant varieties: There are some strawberry varieties that are resistant or tolerant to the Xylella fastidiosa bacterium. Planting these varieties can help prevent or reduce the severity of leaf scorch.";
        break;

      case "Tomato Bacterial Spot":
        possibleCauses =
        "Xanthomonas bacteria which can be introduced into a garden on contaminated seed and transplants, which may or may not show symptoms.";
        possibleSolution =
        "Remove symptomatic plants from the field or greenhouse to prevent the spread of bacteria to healthy plants.";
        break;

      case "Tomato Early Blight":
        possibleCauses =
        "The fungus Alternaria solani, high humidity and long periods of leaf wetness.";
        possibleSolution =
        "Maintaining optimum growing conditions: proper fertilization, irrigation, and pests management.";
        break;

      case "Tomato Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Tomato Late Blight":
        possibleCauses = "Caused by the water mold Phytophthora infestans.";
        possibleSolution = "Timely application of fungicide";
        break;

      case "Tomato Leaf Mold":
        possibleCauses = "High relative humidity (greater than 85%).";
        possibleSolution =
        "Growing leaf mold resistant varieties, use drip irrigation to avoid watering foliage.";
        break;

      case "Tomato Septoria Leaf Spot":
        possibleCauses =
        "It is a fungus and spreads by spores most rapidly in wet or humid weather. Attacks plants in the nightshade family, and can be harbored on weeds within this family.";
        possibleSolution =
        "Remove infected leaves immediately, use organic fungicide options.";
        break;

      case "Tomato Spider mites Two-spotted spider mite":
        possibleCauses =
        "Spider mite feeding on leaves during hot and dry conditions.";
        possibleSolution =
        "Aiming a hard stream of water at infested plants to knock spider mites off the plants. Also use of insecticidal soaps, horticultural oils.";
        break;

      case "Tomato Target Spot":
        possibleCauses =
        "The fungus Corynespora cassiicola which spreads to plants.";
        possibleSolution =
        "Planting resistant varieties, keeping farms free from weeds.";
        break;

      case "Tomato Mosaic Virus":
        possibleCauses =
        "Spread by aphids and other insects, mites, fungi, nematodes, and contact; pollen and seeds can carry the infection as well.";
        possibleSolution =
        "No cure for infected plants, remove all infected plants and destroy them.";
        break;

      case "Tomato Yellow Leaf Curl Virus":
        possibleCauses =
        "Physically spread plant-to-plant by the silverleaf whitefly.";
        possibleSolution =
        "Chemical control: Imidacloprid should be sprayed on the entire plant and below the leaves.";
        break;

      default:
        possibleCauses = "N/A";
        possibleSolution = "N/A";
        break;
    }
  }
}
