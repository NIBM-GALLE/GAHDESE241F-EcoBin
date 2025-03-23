#include <ESP8266WiFi.h>               // For WiFi connection
#include <FirebaseESP8266.h>      // Firebase library (Use FirebaseESP8266 for ESP8266)
#include <SPI.h>
#include <MFRC522.h>

// WiFi Credentials
#define WIFI_SSID "Dialog 4G 399"
#define WIFI_PASSWORD "31b06c07"

// Firebase Credentials
#define FIREBASE_HOST "https://smart-waste-management-3041a-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "RDAfD0g8mGqZxS2qLHWDKQrWpRJl2hEFKgNwjuDG"

// Firebase and WiFi objects
FirebaseData firebaseData;
FirebaseAuth auth;
FirebaseConfig config;

// Ultrasonic Sensor Pins
#define TRIG_PIN D5  
#define ECHO_PIN D6 

// NFC Module Pins
#define SS_PIN D3  // GPIO4 (SDA/SS)
#define RST_PIN D4 // GPIO5 (Reset)
MFRC522 mfrc522(SS_PIN, RST_PIN);

// Manually defined GPS coordinates
const float lat = 6.036970;  // Example latitude
const float lng = 80.224024; // Example longitude
const String binID = "bin2";
const String location = "Beach Entrance";

void setup() {
  Serial.begin(115200);
  
  // Connect to WiFi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }
  Serial.println(" Connected!");

  // Initialize Firebase
  config.host = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;
  Firebase.begin(&config, &auth);

  // Initialize NFC Module
  SPI.begin();
  mfrc522.PCD_Init();

  // Ultrasonic Sensor
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
}

void loop() {
  // Measure Waste Level
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  long duration = pulseIn(ECHO_PIN, HIGH);
  float wasteLevel = duration * 0.034 / 2;  
  
  // Determine status based on waste level
  String status = "Empty";
  if (wasteLevel > 75) {
    status = "Full";
  } else if (wasteLevel > 40) {
    status = "Half";
  } else {
    status = "Low";
  }

  // Read NFC Card UID
  String cardUID = "No Card";
  if (mfrc522.PICC_IsNewCardPresent() && mfrc522.PICC_ReadCardSerial()) {
    cardUID = "";
    for (byte i = 0; i < mfrc522.uid.size; i++) {
      cardUID += String(mfrc522.uid.uidByte[i], HEX);
    }
    mfrc522.PICC_HaltA();
  }

  // Send Data to Firebase
  String path = "/wasteBins/" + binID;
  Firebase.setString(firebaseData, path + "/id", binID);
  Firebase.setString(firebaseData, path + "/location", location);
  Firebase.setFloat(firebaseData, path + "/lat", lat);
  Firebase.setFloat(firebaseData, path + "/lng", lng);
  Firebase.setFloat(firebaseData, path + "/wasteLevel", wasteLevel);
  Firebase.setString(firebaseData, path + "/status", status);
  Firebase.setString(firebaseData, path + "/nfcAccess", cardUID);

  Serial.println("Data Sent to Firebase!");
  delay(5000); // Send data every 5 seconds
}
