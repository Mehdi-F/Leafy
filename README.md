# leafy
A Flutter app that detects a plant's disease given a photo of an affected leaf.

## Installation
This project requires the installation of Flutter.
See the official installation [documentation](https://docs.flutter.dev/get-started/install) to learn how to install Flutter.
Set up your preferred editor as directed [here](https://docs.flutter.dev/get-started/editor).

Download the project.

```bash
git clone https://github.com/Mehdi-F/Leafy.git
```

Run the below command inside the project directory to install necessary packages.
```bash
flutter pub get
```
To run the project in debug mode 
```bash
flutter run
```

To generate a release build
```bash
flutter build apk
```
Locate the `app-release.apk` file from the directory `build/app/outputs/flutter-apk/` and install in your Android smartphone or emulator to use.


## Usage

On launching the application, the user will be presented by a logging in screen where they can use their email/password to login or simply using Google, and if they're not a member they can join by simply clicking on the link on the bottom of the page. After logging in they will be presented with a welcoming message and the usage instructons. Just take a photo of the plant, or select a photo of the plant from their `gallery`.

The application then runs the TFLITE model in the background to get a identify the disease.
It displays the results on the next screen `Results`

## Important to note
- The `tflite` model has been trained to detect only a subset of the diseases. They include:
    - Apple Apple scab
    - Apple Black rot
    - Apple Cedar apple rust
    - Apple healthy
    - Background without leaves
    - Blueberry healthy
    - Cherry healthy
    - Cherry Powdery mildew
    - Corn Cercospora leaf spot Gray leaf spot
    - Corn Common rust
    - Corn healthy
    - Corn Northern Leaf Blight
    - Grape Black rot
    - Grape Esca (Black Measles)
    - Grape healthy
    - Grape Leaf blight (Isariopsis Leaf Spot)
    - Orange Haunglongbing (Citrus greening)
    - Peach Bacterial spot
    - Peach healthy
    - Pepper bell Bacterial spot
    - Pepper bell healthy
    - Potato Early blight
    - Potato healthy
    - Potato Late blight
    - Raspberry healthy
    - Soybean healthy
    - Squash Powdery mildew
    - Strawberry healthy
    - Strawberry Leaf scorch
    - Tomato Bacterial spot
    - Tomato Early blight
    - Tomato healthy
    - Tomato Late blight
    - Tomato Leaf Mold
    - Tomato Septoria leaf spot
    - Tomato Spider mites Two-spotted spider mite
    - Tomato Target Spot
    - Tomato Tomato mosaic virus
    - Tomato Tomato Yellow Leaf Curl Virus


- The dataset is composed of more than 87000 images of plant leaves, healthy and infected, then I added another 1000+ images of background without leaves to make the model identify other images other than leaves.

- The application was built using Flutter and a `tflite` model from generated from [train_model_cnn.py](php/train_model_cnn.py). The dataset was from [KAGGLE](https://www.kaggle.com/saroz014/plant-diseases).

