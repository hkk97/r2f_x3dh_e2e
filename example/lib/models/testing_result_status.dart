import 'package:example/enum/enum.dart';

class TestinStatus {
  final TestStatus testStatus;

  TestinStatus({
    required this.testStatus,
  });

  TestinStatus update({
    DateTime? startAt,
    DateTime? completedAt,
    required TestStatus testStatus,
  }) {
    return TestinStatus(
      testStatus: testStatus,
    );
  }
}
