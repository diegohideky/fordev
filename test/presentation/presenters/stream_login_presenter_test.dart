import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  validate({ @required String field, @required String value });
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({ @required this.validation });

  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

class ValidatoinSpy extends Mock implements Validation {}

void main() {
  ValidatoinSpy validation;
  StreamLoginPresenter sut;
  String email;

  setUp(() {
    validation = ValidatoinSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
