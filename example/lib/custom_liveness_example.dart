import 'package:flutter_liveness_detection_randomized_plugin/index.dart';

class CustomLivenessExample extends StatefulWidget {
  const CustomLivenessExample({super.key});

  @override
  State<CustomLivenessExample> createState() => _CustomLivenessExampleState();
}

class _CustomLivenessExampleState extends State<CustomLivenessExample> {
  String? imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Liveness Detection'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            if (imgPath != null) ...[
              const Text(
                'Liveness Detection Result',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.file(
                      File(imgPath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Example 1: Only Smile and Blink Detection
            _buildExampleCard(
              title: '😊 + 👁️ Smile & Blink Only',
              description: 'Detect only smile and blink actions',
              onPressed: () => _runSmileAndBlinkExample(),
            ),

            const SizedBox(height: 16),

            // Example 2: Only Smile Detection
            _buildExampleCard(
              title: '😊 Smile Only',
              description: 'Detect only smile action with custom threshold',
              onPressed: () => _runSmileOnlyExample(),
            ),

            const SizedBox(height: 16),

            // Example 3: Only Blink Detection
            _buildExampleCard(
              title: '👁️ Blink Only',
              description: 'Detect only blink action with custom settings',
              onPressed: () => _runBlinkOnlyExample(),
            ),

            const SizedBox(height: 16),

            // Example 4: Custom Multiple Actions
            _buildExampleCard(
              title: '🎭 Custom Multiple Actions',
              description: 'Custom combination: Smile + Blink + Look Up',
              onPressed: () => _runCustomMultipleExample(),
            ),

            const SizedBox(height: 16),

            // Example 5: Advanced Custom Configuration
            _buildExampleCard(
              title: '⚙️ Advanced Custom Config',
              description: 'Fully customized with thresholds and labels',
              onPressed: () => _runAdvancedCustomExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start Detection'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Example 1: Only Smile and Blink Detection
  Future<void> _runSmileAndBlinkExample() async {
    final String? response = await FlutterLivenessDetectionRandomizedPlugin
        .instance
        .livenessDetection(
      context: context,
      config: LivenessDetectionConfig.smileAndBlink(
        startWithInfoScreen: true,
        durationLivenessVerify: 30,
        smileLabel: "Please Smile 😊",
        blinkLabel: "Blink Your Eyes 👁️",
        smileThreshold: 0.8, // Higher threshold for more confident smile
        blinkLeftEyeThreshold:
            0.2, // Lower threshold for easier blink detection
        blinkRightEyeThreshold: 0.2,
        randomizeStepOrder: true,
      ),
      isEnableSnackBar: true,
      showCurrentStep: true,
      isDarkMode: false,
    );

    if (mounted && response != null) {
      setState(() => imgPath = response);
    }
  }

  /// Example 2: Only Smile Detection
  Future<void> _runSmileOnlyExample() async {
    final String? response = await FlutterLivenessDetectionRandomizedPlugin
        .instance
        .livenessDetection(
      context: context,
      config: LivenessDetectionConfig.custom(
        steps: [LivenessDetectionStep.smile],
        customLabels: {
          LivenessDetectionStep.smile: "Show me your beautiful smile! 😄",
        },
        customThresholds: {
          LivenessDetectionStep.smile: 0.7, // Custom smile threshold
        },
        durationLivenessVerify: 20,
        randomizeStepOrder: false, // Only one step, no need to randomize
      ),
      isEnableSnackBar: true,
      showCurrentStep: true,
      isDarkMode: false,
    );

    if (mounted && response != null) {
      setState(() => imgPath = response);
    }
  }

  /// Example 3: Only Blink Detection
  Future<void> _runBlinkOnlyExample() async {
    final String? response = await FlutterLivenessDetectionRandomizedPlugin
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
        startWithInfoScreen: false, // Skip info screen for quick detection
      ),
      isEnableSnackBar: true,
      showCurrentStep: false, // Hide step counter for single step
      isDarkMode: false,
    );

    if (mounted && response != null) {
      setState(() => imgPath = response);
    }
  }

  /// Example 4: Custom Multiple Actions
  Future<void> _runCustomMultipleExample() async {
    final String? response = await FlutterLivenessDetectionRandomizedPlugin
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
          LivenessDetectionStep.lookUp: 15.0, // Head angle threshold
        },
        durationLivenessVerify: 45,
        randomizeStepOrder: true,
      ),
      isEnableSnackBar: true,
      showCurrentStep: true,
      isDarkMode: false,
    );

    if (mounted && response != null) {
      setState(() => imgPath = response);
    }
  }

  /// Example 5: Advanced Custom Configuration
  Future<void> _runAdvancedCustomExample() async {
    // Create custom detection steps with specific configurations
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

    final String? response = await FlutterLivenessDetectionRandomizedPlugin
        .instance
        .livenessDetection(
      context: context,
      config: LivenessDetectionConfig(
        customDetectionSteps: customSteps,
        randomizeStepOrder: true,
        startWithInfoScreen: true,
        durationLivenessVerify: 60,
        showDurationUiText: true, // Show countdown timer
        imageQuality: 95, // High quality image
        isEnableMaxBrightness: true,
      ),
      isEnableSnackBar: true,
      showCurrentStep: true,
      isDarkMode: false,
    );

    if (mounted && response != null) {
      setState(() => imgPath = response);
    }
  }
}
