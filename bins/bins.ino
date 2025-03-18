#include <ESP8266WiFi.h>               // For WiFi connection
#include <FirebaseESP8266.h>      // Firebase library (Use FirebaseESP8266 for ESP8266)
#include <SPI.h>
#include <MFRC522.h>

// WiFi Credentials
#define WIFI_SSID "Realme 7"
#define WIFI_PASSWORD "123456789"

// Firebase Credentials
#define FIREBASE_HOST "https://smart-waste-management-3041a-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "RDAfD0g8mGqZxS2qLHWDKQrWpRJl2hEFKgNwjuDG"

// Firebase and WiFi objects
FirebaseData firebaseData;
FirebaseAuth auth;
FirebaseConfig config;

// Ultrasonic Sensor Pins
#define TRIG_PIN D1  
#define ECHO_PIN D2 

// NFC Module Pins
#define SS_PIN D3  // GPIO4 (SDA/SS)
#define RST_PIN D4 // GPIO5 (Reset)
MFRC522 mfrc522(SS_PIN, RST_PIN);


// Manually defined GPS coordinates
const float lat = 6.9271;  // Example latitude
const float lng = 79.8612; // Example longitude

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
  Firebase.setFloat(firebaseData, "/wasteBins/bin1/wasteLevel", wasteLevel);
  Firebase.setFloat(firebaseData, "/wasteBins/bin1/lat", lat);
  Firebase.setFloat(firebaseData, "/wasteBins/bin1/lng", lng);
  Firebase.setString(firebaseData, "/wasteBins/bin1/nfcAccess", cardUID);

  Serial.println("Data Sent to Firebase!");
  delay(5000); // Send data every 5 seconds
}
