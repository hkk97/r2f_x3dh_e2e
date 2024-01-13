import 'package:example/enum/enum.dart';

class TestinStatus {
  final TestStatus testStatus; // The current test status

  TestinStatus({
    required this.testStatus, // The current test status
  });

  // Update the test status with optional startAt and completedAt parameters
  TestinStatus update({
    DateTime? startAt, // The start time of the test (optional)
    DateTime? completedAt, // The completion time of the test (optional)
    required TestStatus testStatus, // The new test status
  }) {
    return TestinStatus(
      testStatus: testStatus,
    );
  }
}
