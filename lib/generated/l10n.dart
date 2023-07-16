// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `name :`
  String get name {
    return Intl.message(
      'name :',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `date :`
  String get date {
    return Intl.message(
      'date :',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Detail Screen`
  String get detail_screen {
    return Intl.message(
      'Detail Screen',
      name: 'detail_screen',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP sent to your phone number`
  String get descriptionOTP {
    return Intl.message(
      'Enter the OTP sent to your phone number',
      name: 'descriptionOTP',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Number `
  String get getNumber {
    return Intl.message(
      'Enter your Number ',
      name: 'getNumber',
      desc: '',
      args: [],
    );
  }

  /// `SignIn`
  String get Sign {
    return Intl.message(
      'SignIn',
      name: 'Sign',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Number`
  String get enterNumber {
    return Intl.message(
      'Enter your Number',
      name: 'enterNumber',
      desc: '',
      args: [],
    );
  }

  /// `The Number is short`
  String get ShortNumber {
    return Intl.message(
      'The Number is short',
      name: 'ShortNumber',
      desc: '',
      args: [],
    );
  }

  /// `Waiting Plaese... `
  String get wait {
    return Intl.message(
      'Waiting Plaese... ',
      name: 'wait',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your OTP`
  String get EnterOTP {
    return Intl.message(
      'Enter Your OTP',
      name: 'EnterOTP',
      desc: '',
      args: [],
    );
  }

  /// `Error The OTP`
  String get ErrorOTP {
    return Intl.message(
      'Error The OTP',
      name: 'ErrorOTP',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get nameApp {
    return Intl.message(
      'School',
      name: 'nameApp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to The School Application`
  String get welcome {
    return Intl.message(
      'Welcome to The School Application',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Select Class`
  String get selectClass {
    return Intl.message(
      'Select Class',
      name: 'selectClass',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
