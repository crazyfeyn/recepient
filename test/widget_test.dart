import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/ui/screens/auth_screen/register_screen.dart';
import 'package:flutter_application/ui/screens/category_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  tearDown(() {
    mockAuthBloc.close();
  });

  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _buildRegisterScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (context) => mockAuthBloc,
          child: RegisterScreen(),
        ),
      ),
    );
  }



  testWidgets('should display error message when in ErrorAuthState',
      (WidgetTester tester) async {
    const errorMessage = 'Registration Failed';
    when(() => mockAuthBloc.state)
        .thenReturn(ErrorAuthState(errorMessage: errorMessage));

    await _buildRegisterScreen(tester);

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('should display form elements correctly',
      (WidgetTester tester) async {
    when(() => mockAuthBloc.state).thenReturn(InitialAuthState());

    await _buildRegisterScreen(tester);

    expect(find.text('SIGN UP'), findsOneWidget);
    expect(find.byType(TextFormField),
        findsNWidgets(4)); // Name, Email, Password, Confirm Password
    expect(find.text('Create an Account'), findsOneWidget);
  });

  testWidgets('should dispatch RegisterUserEvent when valid form is submitted',
      (WidgetTester tester) async {
    when(() => mockAuthBloc.state).thenReturn(InitialAuthState());

    await _buildRegisterScreen(tester);

    await tester.enterText(find.byKey(const Key('nameField')), 'Test User');
    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
    await tester.enterText(
        find.byKey(const Key('confirmPasswordField')), 'password123');

    await tester.tap(find.text('Create an Account'));
    await tester.pump();

    verify(() => mockAuthBloc.add(RegisterUserEvent(
          name: 'Test User',
          email: 'test@example.com',
          password: 'password123',
        ))).called(1);
  });

  testWidgets('should navigate to CategoryWidget on AuthenticatedState',
      (WidgetTester tester) async {
    whenListen(
      mockAuthBloc,
      Stream<AuthState>.fromIterable(
          [LoadingAuthState(), AuthenticatedState()]),
      initialState: InitialAuthState(),
    );
    await _buildRegisterScreen(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CategoryWidget), findsOneWidget);
  });
}
