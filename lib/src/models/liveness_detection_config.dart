import 'package:flutter_liveness_detection_randomized_plugin/src/models/liveness_detection_label_model.dart';
import 'package:flutter_liveness_detection_randomized_plugin/src/models/liveness_detection_step_item.dart';
import 'package:flutter_liveness_detection_randomized_plugin/src/core/enums/liveness_detection_step.dart';

class LivenessDetectionConfig {
  final bool startWithInfoScreen;
  final int? durationLivenessVerify;
  final bool showDurationUiText;
  final bool useCustomizedLabel;
  final LivenessDetectionLabelModel? customizedLabel;
  final bool isEnableMaxBrightness;
  final int imageQuality;

  /// List of detection steps to perform. If null, uses all available steps.
  /// Developers can specify only the steps they want (e.g., only smile and blink)
  final List<LivenessDetectionStepItem>? customDetectionSteps;

  /// Whether to randomize the order of detection steps
  final bool randomizeStepOrder;

  LivenessDetectionConfig({
    this.startWithInfoScreen = false,
    this.durationLivenessVerify = 45,
    this.showDurationUiText = false,
    this.useCustomizedLabel = false,
    this.customizedLabel,
    this.isEnableMaxBrightness = true,
    this.imageQuality = 100,
    this.customDetectionSteps,
    this.randomizeStepOrder = true,
  });

  /// Helper method to create config with only smile and blink detection
  factory LivenessDetectionConfig.smileAndBlink({
    bool startWithInfoScreen = false,
    int? durationLivenessVerify = 45,
    bool showDurationUiText = false,
    bool isEnableMaxBrightness = true,
    int imageQuality = 100,
    bool randomizeStepOrder = true,
    String? smileLabel,
    String? blinkLabel,
    double? smileThreshold,
    double? blinkLeftEyeThreshold,
    double? blinkRightEyeThreshold,
  }) {
    return LivenessDetectionConfig(
      startWithInfoScreen: startWithInfoScreen,
      durationLivenessVerify: durationLivenessVerify,
      showDurationUiText: showDurationUiText,
      isEnableMaxBrightness: isEnableMaxBrightness,
      imageQuality: imageQuality,
      randomizeStepOrder: randomizeStepOrder,
      customDetectionSteps: [
        LivenessDetectionStepItem(
          step: LivenessDetectionStep.smile,
          title: smileLabel ?? "Smile",
          thresholdToCheck: smileThreshold ?? 0.75,
        ),
        LivenessDetectionStepItem(
          step: LivenessDetectionStep.blink,
          title: blinkLabel ?? "Blink 2-3 Times",
          thresholdToCheck: blinkLeftEyeThreshold ?? 0.25,
        ),
      ],
    );
  }

  /// Helper method to create config with only specific steps
  factory LivenessDetectionConfig.custom({
    required List<LivenessDetectionStep> steps,
    bool startWithInfoScreen = false,
    int? durationLivenessVerify = 45,
    bool showDurationUiText = false,
    bool isEnableMaxBrightness = true,
    int imageQuality = 100,
    bool randomizeStepOrder = true,
    Map<LivenessDetectionStep, String>? customLabels,
    Map<LivenessDetectionStep, double>? customThresholds,
  }) {
    List<LivenessDetectionStepItem> detectionSteps = steps.map((step) {
      String defaultTitle;
      double? defaultThreshold;

      switch (step) {
        case LivenessDetectionStep.blink:
          defaultTitle = "Blink 2-3 Times";
          defaultThreshold = 0.25;
          break;
        case LivenessDetectionStep.smile:
          defaultTitle = "Smile";
          defaultThreshold = 0.75;
          break;
        case LivenessDetectionStep.lookUp:
          defaultTitle = "Look UP";
          defaultThreshold = 20.0;
          break;
        case LivenessDetectionStep.lookDown:
          defaultTitle = "Look DOWN";
          defaultThreshold = -15.0;
          break;
        case LivenessDetectionStep.lookLeft:
          defaultTitle = "Look LEFT";
          defaultThreshold = 30.0;
          break;
        case LivenessDetectionStep.lookRight:
          defaultTitle = "Look RIGHT";
          defaultThreshold = -30.0;
          break;
      }

      return LivenessDetectionStepItem(
        step: step,
        title: customLabels?[step] ?? defaultTitle,
        thresholdToCheck: customThresholds?[step] ?? defaultThreshold,
      );
    }).toList();

    return LivenessDetectionConfig(
      startWithInfoScreen: startWithInfoScreen,
      durationLivenessVerify: durationLivenessVerify,
      showDurationUiText: showDurationUiText,
      isEnableMaxBrightness: isEnableMaxBrightness,
      imageQuality: imageQuality,
      randomizeStepOrder: randomizeStepOrder,
      customDetectionSteps: detectionSteps,
    );
  }
}
