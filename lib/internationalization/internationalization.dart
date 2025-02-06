import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'internationalization_en.dart';
import 'internationalization_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Internationalization
/// returned by `Internationalization.of(context)`.
///
/// Applications need to include `Internationalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'internationalization/internationalization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Internationalization.localizationsDelegates,
///   supportedLocales: Internationalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Internationalization.supportedLocales
/// property.
abstract class Internationalization {
  Internationalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Internationalization of(BuildContext context) {
    return Localizations.of<Internationalization>(context, Internationalization)!;
  }

  static const LocalizationsDelegate<Internationalization> delegate = _InternationalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @coffeePun1.
  ///
  /// In en, this message translates to:
  /// **'☕ Espresso yourself!'**
  String get coffeePun1;

  /// No description provided for @coffeePun2.
  ///
  /// In en, this message translates to:
  /// **'☕ Better latte than never!'**
  String get coffeePun2;

  /// No description provided for @coffeePun3.
  ///
  /// In en, this message translates to:
  /// **'☕ You mocha me crazy!'**
  String get coffeePun3;

  /// No description provided for @coffeePun4.
  ///
  /// In en, this message translates to:
  /// **'☕ Words cannot espresso how much you mean to me!'**
  String get coffeePun4;

  /// No description provided for @coffeePun5.
  ///
  /// In en, this message translates to:
  /// **'☕ Don’t be latte to the party!'**
  String get coffeePun5;

  /// No description provided for @coffeePun6.
  ///
  /// In en, this message translates to:
  /// **'☕ Sip happens, but coffee helps.'**
  String get coffeePun6;

  /// No description provided for @coffeePun7.
  ///
  /// In en, this message translates to:
  /// **'☕ Stay grounded, but keep reaching for the beans!'**
  String get coffeePun7;
}

class _InternationalizationDelegate extends LocalizationsDelegate<Internationalization> {
  const _InternationalizationDelegate();

  @override
  Future<Internationalization> load(Locale locale) {
    return SynchronousFuture<Internationalization>(lookupInternationalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_InternationalizationDelegate old) => false;
}

Internationalization lookupInternationalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return InternationalizationEn();
    case 'es': return InternationalizationEs();
  }

  throw FlutterError(
    'Internationalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
