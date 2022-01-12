import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:parking_finder/MVC%20Structure/Controller/user.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('Given user with name Alfi Mostak is logged in', () async {
    final user = User(24, "Alfi Mostak");

    // ACT
    user.birthday();

    // ASSERT
    expect(user.age, 25);
  });
}
