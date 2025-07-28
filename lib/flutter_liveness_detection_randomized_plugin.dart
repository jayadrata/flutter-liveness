import 'package:flutter_liveness_detection_randomized_plugin/index.dart';

class FlutterLivenessDetectionRandomizedPlugin {
  FlutterLivenessDetectionRandomizedPlugin._privateConstructor();
  static final FlutterLivenessDetectionRandomizedPlugin instance =
      FlutterLivenessDetectionRandomizedPlugin._privateConstructor();
  final List<LivenessDetectionThreshold> _thresholds = [];

  List<LivenessDetectionThreshold> get thresholdConfig {
    return _thresholds;
  }

  /// Configure thresholds for specific detection steps
  void configureThresholds(List<LivenessDetectionStepItem> steps) {
    _thresholds.clear();

    for (var step in steps) {
      if (step.thresholdToCheck != null) {
        switch (step.step) {
          case LivenessDetectionStep.smile:
            _thresholds.add(LivenessThresholdSmile(
              probability: step.thresholdToCheck!,
            ));
            break;
          case LivenessDetectionStep.blink:
            _thresholds.add(LivenessThresholdBlink(
              leftEyeProbability: step.thresholdToCheck!,
              rightEyeProbability: step.thresholdToCheck!,
            ));
            break;
          case LivenessDetectionStep.lookUp:
          case LivenessDetectionStep.lookDown:
          case LivenessDetectionStep.lookLeft:
          case LivenessDetectionStep.lookRight:
            _thresholds.add(LivenessThresholdHead(
              rotationAngle: step.thresholdToCheck!.abs(),
            ));
            break;
        }
      }
    }
  }

  Future<String?> livenessDetection({
    required BuildContext context,
    required LivenessDetectionConfig config,
    required bool isEnableSnackBar,
    bool shuffleListWithSmileLast = true,
    required bool showCurrentStep,
    required bool isDarkMode,
  }) async {
    // Configure thresholds based on selected steps
    if (config.customDetectionSteps != null) {
      configureThresholds(config.customDetectionSteps!);
    }

    final String? capturedFacePath = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LivenessDetectionView(
          config: config,
          isEnableSnackBar: isEnableSnackBar,
          shuffleListWithSmileLast: shuffleListWithSmileLast,
          showCurrentStep: showCurrentStep,
          isDarkMode: isDarkMode,
        ),
      ),
    );
    return capturedFacePath;
  }

  Future<String?> getPlatformVersion() {
    return FlutterLivenessDetectionRandomizedPluginPlatform.instance
        .getPlatformVersion();
  }
}
