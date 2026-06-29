#include <M5StickC.h>  // 初期型M5StickC用ヘッダー
#include <BleKeyboard.h>

BleKeyboard bleKeyboard("M5-Daruma-Hammer");
float threshold = 2.0; // 振りの強さのしきい値。反応が鈍い場合は下げ、敏感すぎる場合は上げてください。

void setup() {
  M5.begin();           // LCD、UART、I2C、IMUを初期化
  M5.IMU.Init();        // IMU（加速度センサ）を個別に初期化
  bleKeyboard.begin();
  
  M5.Lcd.setRotation(1); // 画面を横向きに設定
  M5.Lcd.fillScreen(BLACK);
  M5.Lcd.setCursor(0, 0, 2);
  M5.Lcd.println("BLE Hammer");
  M5.Lcd.println("Ready to Pair...");
}

void loop() {
  M5.update(); // ボタン状態などの更新
  
  if(bleKeyboard.isConnected()) {
    float accX, accY, accZ;
    M5.IMU.getAccelData(&accX, &accY, &accZ); // 加速度データの取得

    if (M5.BtnA.wasPressed()){
    // 正面のボタンを押したら  
      bleKeyboard.write('r');
      delay(100);
    }
    // M5StickCを「画面を自分に向けて」持った場合、水平の振りはaccXに反応します
    if (accX > threshold) {
      M5.Lcd.fillScreen(GREEN);
      bleKeyboard.press(KEY_RIGHT_ARROW);
      delay(50); 
      bleKeyboard.releaseAll();
      M5.Lcd.fillScreen(BLACK);
    } else if (accX < -threshold) {
      M5.Lcd.fillScreen(RED);
      bleKeyboard.press(KEY_LEFT_ARROW);
      delay(50);
      bleKeyboard.releaseAll();
      M5.Lcd.fillScreen(BLACK);
    }
    
    // 画面に現在の加速度を表示（調整用）
    M5.Lcd.setCursor(0, 30, 2);
    M5.Lcd.printf("X: %.2f  ", accX);
  } else {
    // 未接続時は青い画面
    static bool showed_pairing = false;
    if(!showed_pairing){
      M5.Lcd.fillScreen(BLUE);
      M5.Lcd.setCursor(0, 0, 2);
      M5.Lcd.println("Pairing...");
      showed_pairing = true;
    }
  }
  delay(10);
}