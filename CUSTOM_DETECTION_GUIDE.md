# Flutter Liveness Detection - Custom Detection Guide

This guide explains how to use the new customizable face liveness detection features that allow developers to choose specific detection actions like smile and blink.

## 🚀 New Features

### 1. **Fully Dynamic Detection Steps**
- Choose exactly which liveness checks to perform
- Mix and match any combination of: smile, blink, look up, look down, look left, look right
- No more fixed detection sequences

### 2. **Custom Thresholds**
- Set custom sensitivity thresholds for each detection type
- Fine-tune detection accuracy for your specific use case

### 3. **Smart Step Ordering**
- Randomize detection order or keep it fixed
- Special handling for smile-last preferences

### 4. **Easy-to-Use Factory Methods**
- Pre-built configurations for common use cases
- Simple customization options

## 📱 Quick Start Examples

### Only Smile and Blink Detection
```dart
final String? result = await FlutterLivenessDetectionRandomizedPlugin
    .instance
    .livenessDetection(
  context: context,
  config: LivenessDetectionConfig.smileAndBlink(
    smileLabel: "Please Smile 😊",
    blinkLabel: "Blink Your Eyes 👁️",
    smileThreshold: 0.8,        // Higher = more confident smile required
    blinkLeftEyeThreshold: 0.2,  // Lower = easier blink detection
    blinkRightEyeThreshold: 0.2,
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

### Only Smile Detection
```dart
final String? result = await FlutterLivenessDetectionRandomizedPlugin
    .instance
    .livenessDetection(
  context: context,
  config: LivenessDetectionConfig.custom(
    steps: [LivenessDetectionStep.smile],
    customLabels: {
      LivenessDetectionStep.smile: "Show me your beautiful smile! 😄",
    },
    customThresholds: {
      LivenessDetectionStep.smile: 0.7,
    },
    durationLivenessVerify: 20,
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

### Only Blink Detection
```dart
final String? result = await FlutterLivenessDetectionRandomizedPlugin
    .instance
    .livenessDetection(
  context: context,
  config: LivenessDetectionConfig.custom(
    steps: [LivenessDetectionStep.blink],
    customLabels: {
      LivenessDetectionStep.blink: "Blink slowly 2-3 times 👀",
    },
    customThresholds: {
      LivenessDetectionStep.blink: 0.15, // Easier blink detection
    },
    durationLivenessVerify: 15,
    startWithInfoScreen: false,
  ),
  isEnableSnackBar: true,
  showCurrentStep: false,
  isDarkMode: false,
);
```

### Custom Multiple Actions
```dart
final String? result = await FlutterLivenessDetectionRandomizedPlugin
    .instance
    .livenessDetection(
  context: context,
  config: LivenessDetectionConfig.custom(
    steps: [
      LivenessDetectionStep.smile,
      LivenessDetectionStep.blink,
      LivenessDetectionStep.lookUp,
    ],
    customLabels: {
      LivenessDetectionStep.smile: "Smile for the camera! 😊",
      LivenessDetectionStep.blink: "Blink your eyes 👁️",
      LivenessDetectionStep.lookUp: "Look up to the sky ⬆️",
    },
    customThresholds: {
      LivenessDetectionStep.smile: 0.75,
      LivenessDetectionStep.blink: 0.25,
      LivenessDetectionStep.lookUp: 15.0,
    },
    randomizeStepOrder: true,
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

### Advanced Custom Configuration
```dart
// Create fully custom detection steps
final customSteps = [
  LivenessDetectionStepItem(
    step: LivenessDetectionStep.smile,
    title: "🌟 Show Your Best Smile!",
    thresholdToCheck: 0.85, // Very confident smile required
  ),
  LivenessDetectionStepItem(
    step: LivenessDetectionStep.blink,
    title: "✨ Gentle Eye Blink",
    thresholdToCheck: 0.3, // Moderate blink detection
  ),
];

final String? result = await FlutterLivenessDetectionRandomizedPlugin
    .instance
    .livenessDetection(
  context: context,
  config: LivenessDetectionConfig(
    customDetectionSteps: customSteps,
    randomizeStepOrder: true,
    startWithInfoScreen: true,
    durationLivenessVerify: 60,
    showDurationUiText: true,
    imageQuality: 95,
    isEnableMaxBrightness: true,
  ),
  isEnableSnackBar: true,
  showCurrentStep: true,
  isDarkMode: false,
);
```

## 🎯 Available Detection Steps

| Step | Description | Threshold Range | Default Threshold |
|------|-------------|-----------------|-------------------|
| `LivenessDetectionStep.smile` | Detect smile expression | 0.0 - 1.0 | 0.75 |
| `LivenessDetectionStep.blink` | Detect eye blink | 0.0 - 1.0 | 0.25 |
| `LivenessDetectionStep.lookUp` | Detect upward head movement | 0.0 - 180.0° | 20.0° |
| `LivenessDetectionStep.lookDown` | Detect downward head movement | -180.0 - 0.0° | -15.0° |
| `LivenessDetectionStep.lookLeft` | Detect leftward head movement | 0.0 - 180.0° | 30.0° |
| `LivenessDetectionStep.lookRight` | Detect rightward head movement | -180.0 - 0.0° | -30.0° |

## 🛠️ Configuration Options

### LivenessDetectionConfig Parameters

```dart
LivenessDetectionConfig({
  // Basic settings
  bool startWithInfoScreen = false,
  int? durationLivenessVerify = 45,
  bool showDurationUiText = false,
  bool isEnableMaxBrightness = true,
  int imageQuality = 100,
  
  // NEW: Custom detection steps
  List<LivenessDetectionStepItem>? customDetectionSteps,
  bool randomizeStepOrder = true,
  
  // Legacy settings (for backward compatibility)
  bool useCustomizedLabel = false,
  LivenessDetectionLabelModel? customizedLabel,
})
```

### Factory Methods

#### 1. `LivenessDetectionConfig.smileAndBlink()`
Perfect for simple smile and blink verification:
- `smileLabel`: Custom text for smile step
- `blinkLabel`: Custom text for blink step  
- `smileThreshold`: Smile detection sensitivity (0.0-1.0)
- `blinkLeftEyeThreshold`: Left eye blink sensitivity (0.0-1.0)
- `blinkRightEyeThreshold`: Right eye blink sensitivity (0.0-1.0)

#### 2. `LivenessDetectionConfig.custom()`
For any combination of detection steps:
- `steps`: List of `LivenessDetectionStep` enums
- `customLabels`: Map of step-specific labels
- `customThresholds`: Map of step-specific thresholds

## 💡 Best Practices

### 1. **Threshold Tuning**
- **Smile**: Start with 0.7-0.8 for reliable detection
- **Blink**: Use 0.2-0.3 for natural blink detection
- **Head Movement**: Use 15-30 degrees for comfortable head turns

### 2. **Step Combinations**
- **Quick Verification**: Smile only or Blink only
- **Balanced Security**: Smile + Blink
- **High Security**: Smile + Blink + 1-2 head movements

### 3. **User Experience**
- Use clear, friendly labels
- Set reasonable time limits (15-60 seconds)
- Consider showing step progress for multiple actions

### 4. **Performance**
- Fewer steps = faster detection
- Higher thresholds = more accurate but potentially slower
- Test thresholds with your target users

## 🔄 Migration from Legacy Version

### Old Way (Limited):
```dart
config: LivenessDetectionConfig(
  useCustomizedLabel: true,
  customizedLabel: LivenessDetectionLabelModel(
    smile: "Smile",
    blink: "Blink",
    lookUp: "", // Empty to skip
    lookDown: "", // Empty to skip
    lookLeft: "", // Empty to skip
    lookRight: "", // Empty to skip
  ),
),
```

### New Way (Powerful):
```dart
config: LivenessDetectionConfig.custom(
  steps: [
    LivenessDetectionStep.smile,
    LivenessDetectionStep.blink,
  ],
  customLabels: {
    LivenessDetectionStep.smile: "Smile",
    LivenessDetectionStep.blink: "Blink",
  },
  customThresholds: {
    LivenessDetectionStep.smile: 0.8,
    LivenessDetectionStep.blink: 0.25,
  },
),
```

## 🤝 Backward Compatibility

The plugin maintains full backward compatibility. Existing code using `useCustomizedLabel` and `customizedLabel` will continue to work unchanged.

## 🎨 Example App

Check out the `custom_liveness_example.dart` file in the example folder for a complete implementation showing all the new features in action!

---

## 💬 Need Help?

If you have questions about implementing custom liveness detection:
1. Check the example app for working implementations
2. Review the threshold recommendations above
3. Test with different threshold values for your use case
4. Consider your users' comfort and accessibility needs
