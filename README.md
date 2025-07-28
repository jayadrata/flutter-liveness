# Flutter Liveness Detection Randomized Plugin

A Flutter plugin for liveness detection with randomized challenge response method with an interaction mechanism between the user and the system in the form of a movement challenge that indicates life is detected on the face. This plugin helps implement secure biometric authentication by detecting real human presence through dynamic facial verification challenges.

## 🚀 NEW: Fully Customizable Detection Steps

**Now you can choose exactly which liveness checks to perform!** 

- ✅ **Only Smile Detection** - Perfect for user-friendly verification
- ✅ **Only Blink Detection** - Quick and reliable liveness check  
- ✅ **Smile + Blink Only** - Best balance of security and UX
- ✅ **Custom Combinations** - Mix any detection steps you want
- ✅ **Dynamic Thresholds** - Fine-tune sensitivity for each detection type
- ✅ **Custom Labels** - Personalize instructions for your users

**👀 Quick Example - Only Smile & Blink:**
```dart
config: LivenessDetectionConfig.smileAndBlink(
  smileLabel: "Please Smile 😊",
  blinkLabel: "Blink Your Eyes 👁️", 
  smileThreshold: 0.8,
  blinkLeftEyeThreshold: 0.2,
),
```

📖 **[See Complete Custom Detection Guide →](CUSTOM_DETECTION_GUIDE.md)**

[![pub package](https://img.shields.io/pub/v/flutter_liveness_detection_randomized_plugin.svg)](https://pub.dev/packages/flutter_liveness_detection_randomized_plugin)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/50b64954ad654b65b0424d266399b026)](https://app.codacy.com/gh/bagussubagja/flutter-liveness-detection-randomized-plugin/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

## Preview 🪟
![Slide 16_9 - 1](https://github.com/user-attachments/assets/55e59d51-e0da-4562-879e-ae50adaced33)

https://github.com/user-attachments/assets/f7266dc9-c4a2-4fba-8684-0ead2f678180

## Update 1.0.6
![Slide 16_9 - 9](https://github.com/user-attachments/assets/3a9b187a-ccfd-4542-a8d9-88b7ef7903a9)
Face stretching already fixed on this version

## Features ✨

### 🆕 **New Customizable Detection (v1.0.7+)**
- 🎯 **Choose Specific Actions**: Select only smile, blink, or any combination
- 🔧 **Dynamic Thresholds**: Adjust sensitivity for each detection type  
- 🏷️ **Custom Labels**: Personalize user instructions
- ⚡ **Optimized Performance**: Faster detection with fewer steps
- 🎲 **Smart Randomization**: Intelligent step ordering

### 🔧 **Core Features**
- 📱 Real-time face detection
- 🎲 Randomized challenge sequence generation
- 💫 Cross-platform support (iOS & Android) 
- 🎨 Light and dark mode support
- ✅ High accuracy liveness verification
- 🚀 Simple integration API
- 🎭 Customizable liveness challenge labels
- ⏳ Flexible security verification duration
- 🎲 Adjustable number of liveness challenges
- 🛠️ Adjustable image quality result

## Getting Started 🌟

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_liveness_detection_randomized_plugin: ^1.0.6
```

### 🚀 Quick Start - Custom Detection

#### Only Smile & Blink (Recommended)
```dart
final result = await FlutterLivenessDetectionRandomizedPlugin.instance.livenessDetection(
  context: context,
  config: LivenessDetectionConfig.smileAndBlink(
    smileLabel: "Please Smile 😊",
    blinkLabel: "Blink Your Eyes 👁️",
    smileThreshold: 0.8,
    blinkLeftEyeThreshold: 0.2,
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

#### Only Smile Detection
```dart
final result = await FlutterLivenessDetectionRandomizedPlugin.instance.livenessDetection(
  context: context,
  config: LivenessDetectionConfig.custom(
    steps: [LivenessDetectionStep.smile],
    customLabels: {LivenessDetectionStep.smile: "Show me your smile! 😄"},
    customThresholds: {LivenessDetectionStep.smile: 0.7},
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

#### Only Blink Detection  
```dart
final result = await FlutterLivenessDetectionRandomizedPlugin.instance.livenessDetection(
  context: context,
  config: LivenessDetectionConfig.custom(
    steps: [LivenessDetectionStep.blink],
    customLabels: {LivenessDetectionStep.blink: "Blink slowly 👀"},
    customThresholds: {LivenessDetectionStep.blink: 0.25},
  ),
  isEnableSnackBar: true,
  showCurrentStep: false,
  isDarkMode: false,
);
```

📖 **[Complete Custom Detection Guide & Examples →](CUSTOM_DETECTION_GUIDE.md)**

## Customized Steps Label
You can customized steps label or use certain step only of liveness challenge with this example :
```
config: LivenessDetectionConfig(
customizedLabel: LivenessDetectionLabelModel(
  blink: '', // add empty string to skip/pass this liveness challenge
  lookDown: '',
  lookLeft: '',
  lookRight: '',
  lookUp: 'Tengok Atas', // example of customize label name for liveness challenge. it will replace default 'look up'
  smile: null, // null value to use default label name
),
),
```

## Platform Setup

### Android
Add camera permission to your AndroidManifest.xml:
```
<uses-permission android:name="android.permission.CAMERA"/>
```
Minimum SDK version: 23

### iOS
Add camera usage description to Info.plist:
```
<key>NSCameraUsageDescription</key>
<string>Camera access is required for liveness detection</string>
```
