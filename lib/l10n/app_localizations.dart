import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'George Mamdouh'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Crafting delightful digital products'**
  String get splashTagline;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter | Android | UI Designer'**
  String get homeTitle;

  /// No description provided for @homeIntro.
  ///
  /// In en, this message translates to:
  /// **'Passionate mobile developer focused on building beautiful, scalable, and modern applications.'**
  String get homeIntro;

  /// No description provided for @viewProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get viewProjects;

  /// No description provided for @downloadCv.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCv;

  /// No description provided for @featuredProjects.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get featuredProjects;

  /// No description provided for @searchProjects.
  ///
  /// In en, this message translates to:
  /// **'Search projects'**
  String get searchProjects;

  /// No description provided for @noProjectsFound.
  ///
  /// In en, this message translates to:
  /// **'No projects found for your current filters.'**
  String get noProjectsFound;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @mySkills.
  ///
  /// In en, this message translates to:
  /// **'My Skills'**
  String get mySkills;

  /// No description provided for @getInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get getInTouch;

  /// No description provided for @letsWorkTogether.
  ///
  /// In en, this message translates to:
  /// **'Let\'s work together!'**
  String get letsWorkTogether;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Feel free to reach out for collaborations or just a friendly hello.'**
  String get contactSubtitle;

  /// No description provided for @sendMeMessage.
  ///
  /// In en, this message translates to:
  /// **'Send me a message'**
  String get sendMeMessage;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @messageSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully! I will get back to you soon.'**
  String get messageSentSuccess;

  /// No description provided for @messageSendError.
  ///
  /// In en, this message translates to:
  /// **'Could not send message right now. Please try again.'**
  String get messageSendError;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a message'**
  String get pleaseEnterMessage;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @aboutProject.
  ///
  /// In en, this message translates to:
  /// **'About this project'**
  String get aboutProject;

  /// No description provided for @keyFeatures.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get keyFeatures;

  /// No description provided for @visitLive.
  ///
  /// In en, this message translates to:
  /// **'Visit Live'**
  String get visitLive;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @skillMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get skillMobile;

  /// No description provided for @skillBackend.
  ///
  /// In en, this message translates to:
  /// **'Backend'**
  String get skillBackend;

  /// No description provided for @skillTools.
  ///
  /// In en, this message translates to:
  /// **'Tools & Design'**
  String get skillTools;

  /// No description provided for @project1Title.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce App'**
  String get project1Title;

  /// No description provided for @project1Desc.
  ///
  /// In en, this message translates to:
  /// **'Modern shopping experience with seamless animations, real-time updates, and secure checkout.'**
  String get project1Desc;

  /// No description provided for @project1Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Stripe Integration'**
  String get project1Highlight1;

  /// No description provided for @project1Highlight2.
  ///
  /// In en, this message translates to:
  /// **'Real-time Cart'**
  String get project1Highlight2;

  /// No description provided for @project1Highlight3.
  ///
  /// In en, this message translates to:
  /// **'User Authentication'**
  String get project1Highlight3;

  /// No description provided for @project2Title.
  ///
  /// In en, this message translates to:
  /// **'Social Media Dashboard'**
  String get project2Title;

  /// No description provided for @project2Desc.
  ///
  /// In en, this message translates to:
  /// **'Analytics dashboard providing deep insights into social media engagement and metrics.'**
  String get project2Desc;

  /// No description provided for @project2Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Custom Charts'**
  String get project2Highlight1;

  /// No description provided for @project2Highlight2.
  ///
  /// In en, this message translates to:
  /// **'Dark/Light Mode'**
  String get project2Highlight2;

  /// No description provided for @project2Highlight3.
  ///
  /// In en, this message translates to:
  /// **'REST API Integration'**
  String get project2Highlight3;

  /// No description provided for @project3Title.
  ///
  /// In en, this message translates to:
  /// **'Fitness Tracker App'**
  String get project3Title;

  /// No description provided for @project3Desc.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive fitness tracking application to monitor workouts and progress over time.'**
  String get project3Desc;

  /// No description provided for @project3Highlight1.
  ///
  /// In en, this message translates to:
  /// **'Offline Support'**
  String get project3Highlight1;

  /// No description provided for @project3Highlight2.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get project3Highlight2;

  /// No description provided for @project3Highlight3.
  ///
  /// In en, this message translates to:
  /// **'Progress Analytics'**
  String get project3Highlight3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
