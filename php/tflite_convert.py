import tensorflow as tf

# Load the .h5 model
model = tf.keras.models.load_model('plant_disease.h5')

# Convert the model to TensorFlow Lite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the TensorFlow Lite model
with open('plant_disease.tflite', 'wb') as f:
    f.write(tflite_model)
