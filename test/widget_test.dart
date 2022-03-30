// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/main.dart';
import 'package:todo/signin/signin_service.dart';
import 'package:todo/widgets/custom_text_field.dart';

class MockSignInService implements SignInService {
  @override
  bool signIn(String email, String password) {
    return email == 'rsanchezsk@gmail.com' && password == '123456';
  }
}

void main() {
  testWidgets('empty email and password', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    Finder email = find.byKey(new Key('email'));
    Finder password = find.byKey(new Key('password'));

    print("Getting email widget");
    print(email.toString());

    print("Getting password widget");
    print(password.toString());

    print("Getting form widget");
    Finder formWidgetFinder = find.byType(Form);
    print(formWidgetFinder.toString());

    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    expect(formKey.currentState!.validate(), isFalse);
  });

  testWidgets('email and password with values', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    Finder email = find.byKey(new Key('email'));
    Finder password = find.byKey(new Key('password'));

    await tester.enterText(email, "rsanchezsk@gmail.com");
    await tester.enterText(password, "123456");
    await tester.pump();

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('sign in success', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    Finder email = find.byKey(new Key('email'));
    Finder password = find.byKey(new Key('password'));

    await tester.enterText(email, "rsanchezsk@gmail.com");
    await tester.enterText(password, "123456");
    await tester.pump();

    CustomTextField emailTextField = tester.firstWidget(email);
    String emailValue = emailTextField.textController.text;

    CustomTextField passwordTextField = tester.firstWidget(password);
    String passwordValue = passwordTextField.textController.text;

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    expect(formKey.currentState!.validate(), isTrue);
    expect(MockSignInService().signIn(emailValue, passwordValue), isTrue);
  });

  testWidgets('sign in fail', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    Finder email = find.byKey(new Key('email'));
    Finder password = find.byKey(new Key('password'));

    await tester.enterText(email, "rsanchez@gmail.com");
    await tester.enterText(password, "123");
    await tester.pump();

    CustomTextField emailTextField = tester.firstWidget(email);
    String emailValue = emailTextField.textController.text;

    CustomTextField passwordTextField = tester.firstWidget(password);
    String passwordValue = passwordTextField.textController.text;

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    expect(formKey.currentState!.validate(), isTrue);
    expect(MockSignInService().signIn(emailValue, passwordValue), isFalse);
  });
}
