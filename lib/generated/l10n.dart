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

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Email or Username`
  String get logver {
    return Intl.message(
      'Please enter your Email or Username',
      name: 'logver',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Blocked people`
  String get blockedPeople {
    return Intl.message(
      'Blocked people',
      name: 'blockedPeople',
      desc: '',
      args: [],
    );
  }

  /// `You see the profiles that you blocked. Open them and\n use the buttons to unlock.`
  String get youSeeTheProfilesThatYouBlocked {
    return Intl.message(
      'You see the profiles that you blocked. Open them and\n use the buttons to unlock.',
      name: 'youSeeTheProfilesThatYouBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Username...`
  String get username {
    return Intl.message(
      'Username...',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Current password...`
  String get currentPassword {
    return Intl.message(
      'Current password...',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password...`
  String get newPassword {
    return Intl.message(
      'New password...',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Retype new password...`
  String get retypeNewPassword {
    return Intl.message(
      'Retype new password...',
      name: 'retypeNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit Notification`
  String get editNotification {
    return Intl.message(
      'Edit Notification',
      name: 'editNotification',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Message Sent Successfully`
  String get sucssMessage {
    return Intl.message(
      'Message Sent Successfully',
      name: 'sucssMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enable notifications for incoming messages`
  String get enableNotificationsForIncomingMessages {
    return Intl.message(
      'Enable notifications for incoming messages',
      name: 'enableNotificationsForIncomingMessages',
      desc: '',
      args: [],
    );
  }

  /// `Enable Message Sound`
  String get enableNotificationsForIncomingMessageSounds {
    return Intl.message(
      'Enable Message Sound',
      name: 'enableNotificationsForIncomingMessageSounds',
      desc: '',
      args: [],
    );
  }

  /// `Message Sound`
  String get MessageSounds {
    return Intl.message(
      'Message Sound',
      name: 'MessageSounds',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Turn on alerts when you are added to favorites`
  String get turnOnAlertsWhenYouAreAddedToFavorites {
    return Intl.message(
      'Turn on alerts when you are added to favorites',
      name: 'turnOnAlertsWhenYouAreAddedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `People nearby`
  String get peopleNearby {
    return Intl.message(
      'People nearby',
      name: 'peopleNearby',
      desc: '',
      args: [],
    );
  }

  /// `Enable alerts for new people around you`
  String get enableAlertsForNewPeopleAroundYou {
    return Intl.message(
      'Enable alerts for new people around you',
      name: 'enableAlertsForNewPeopleAroundYou',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get smessages {
    return Intl.message(
      'Message',
      name: 'smessages',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Normal account`
  String get normalAccount {
    return Intl.message(
      'Normal account',
      name: 'normalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Membership`
  String get upgradePlan {
    return Intl.message(
      'Upgrade Membership',
      name: 'upgradePlan',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade plan`
  String get upgradePlan2 {
    return Intl.message(
      'Upgrade plan',
      name: 'upgradePlan2',
      desc: '',
      args: [],
    );
  }

  /// `My likes`
  String get likedPeople {
    return Intl.message(
      'My likes',
      name: 'likedPeople',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Usage Policy`
  String get usagePolicy {
    return Intl.message(
      'Usage Policy',
      name: 'usagePolicy',
      desc: '',
      args: [],
    );
  }

  /// `policy`
  String get policy {
    return Intl.message(
      'policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Support Team`
  String get supportTeam {
    return Intl.message(
      'Support Team',
      name: 'supportTeam',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get upgrade {
    return Intl.message(
      'Upgrade',
      name: 'upgrade',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `My likes`
  String get myLikes {
    return Intl.message(
      'My likes',
      name: 'myLikes',
      desc: '',
      args: [],
    );
  }

  /// `You can see the profiles that you liked earlier.`
  String get youCanSeeTheProfilesThatYouLikedEarlier {
    return Intl.message(
      'You can see the profiles that you liked earlier.',
      name: 'youCanSeeTheProfilesThatYouLikedEarlier',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message(
      'Enabled',
      name: 'enabled',
      desc: '',
      args: [],
    );
  }

  /// `My account is not visible to everyone`
  String get myAccountIsNotVisibleToEveryone {
    return Intl.message(
      'My account is not visible to everyone',
      name: 'myAccountIsNotVisibleToEveryone',
      desc: '',
      args: [],
    );
  }

  /// `Show my account`
  String get showMyAccount {
    return Intl.message(
      'Show my account',
      name: 'showMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get tickets {
    return Intl.message(
      'Tickets',
      name: 'tickets',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Send message to us:`
  String get sendMessageToUs {
    return Intl.message(
      'Send message to us:',
      name: 'sendMessageToUs',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to HiLike! If you hove any problem on \nHiLike, please report to us through feedback`
  String get welcomeToHilikeIfYouHoveAnyProblem {
    return Intl.message(
      'Welcome to HiLike! If you hove any problem on \nHiLike, please report to us through feedback',
      name: 'welcomeToHilikeIfYouHoveAnyProblem',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Enter Subject`
  String get enterSubject {
    return Intl.message(
      'Enter Subject',
      name: 'enterSubject',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Enter your message`
  String get enterYourMessage {
    return Intl.message(
      'Enter your message',
      name: 'enterYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Suggestion`
  String get suggestion {
    return Intl.message(
      'Suggestion',
      name: 'suggestion',
      desc: '',
      args: [],
    );
  }

  /// `Problem`
  String get problem {
    return Intl.message(
      'Problem',
      name: 'problem',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get membership {
    return Intl.message(
      'Membership',
      name: 'membership',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get other {
    return Intl.message(
      'Others',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Write message`
  String get writeMessage {
    return Intl.message(
      'Write message',
      name: 'writeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enable notifications!`
  String get enableNotifications {
    return Intl.message(
      'Enable notifications!',
      name: 'enableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Activate notifications now to make sure you dont \nmiss any messages`
  String get activateNotificationsNow {
    return Intl.message(
      'Activate notifications now to make sure you dont \\nmiss any messages',
      name: 'activateNotificationsNow',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Create new \npassword`
  String get createNewPassword {
    return Intl.message(
      'Create new \\npassword',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `You can create new password and confirm\nit below`
  String get youCanCreateNewPassword {
    return Intl.message(
      'You can create new password and confirm\\nit below',
      name: 'youCanCreateNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password...`
  String get confirmPassword {
    return Intl.message(
      'Confirm password...',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `We will send a new password to your email`
  String get weWillSendNewPasswordToYourEmail {
    return Intl.message(
      'We will send a new password to your email',
      name: 'weWillSendNewPasswordToYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your mail...`
  String get yourMail {
    return Intl.message(
      'Your mail...',
      name: 'yourMail',
      desc: '',
      args: [],
    );
  }

  /// `verification`
  String get verification {
    return Intl.message(
      'verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Email\nVerification`
  String get emailVerification {
    return Intl.message(
      'Email\\nVerification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a code to your email:`
  String get weHaveSentaCodeToYourEmail {
    return Intl.message(
      'We\'ve sent a code to your email:',
      name: 'weHaveSentaCodeToYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive SMS?`
  String get didNotReceiveSms {
    return Intl.message(
      'Didn\'t receive SMS?',
      name: 'didNotReceiveSms',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resendCode {
    return Intl.message(
      'Resend code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive email?`
  String get didNotReceiveEmail {
    return Intl.message(
      'Didn\'t receive email?',
      name: 'didNotReceiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message(
      'Continue',
      name: 'continue_',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect try again later`
  String get incorrectTryAgainLater {
    return Intl.message(
      'Incorrect try again later',
      name: 'incorrectTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Choose your language`
  String get chooseYourLanguage {
    return Intl.message(
      'Choose your language',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your language using the button to \npersonalize the search results`
  String get selectYourLanguageUsingTheButton {
    return Intl.message(
      'Select your language using the button to \\npersonalize the search results',
      name: 'selectYourLanguageUsingTheButton',
      desc: '',
      args: [],
    );
  }

  /// `help`
  String get help {
    return Intl.message(
      'help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `The application aims for acquaintance and official \nmarriage to meet your goals and search for the best \nand most appropriate partner in a modern, \nfast and safe way`
  String get theApplicationAimsForAcquaintance {
    return Intl.message(
      'The application aims for acquaintance and official \\nmarriage to meet your goals and search for the best \\nand most appropriate partner in a modern, \\nfast and safe way',
      name: 'theApplicationAimsForAcquaintance',
      desc: '',
      args: [],
    );
  }

  /// `Mission`
  String get mission {
    return Intl.message(
      'Mission',
      name: 'mission',
      desc: '',
      args: [],
    );
  }

  /// `It is in line with Islamic law, community values and \npublic morals, away from dating programs that \nlack seriousness and are not safe`
  String get itIsInLineWithIslamicLaw {
    return Intl.message(
      'It is in line with Islamic law, community values and \\npublic morals, away from dating programs that \\nlack seriousness and are not safe',
      name: 'itIsInLineWithIslamicLaw',
      desc: '',
      args: [],
    );
  }

  /// `Public morals`
  String get publicMorals {
    return Intl.message(
      'Public morals',
      name: 'publicMorals',
      desc: '',
      args: [],
    );
  }

  /// `Use the application for those aged 18 years and over`
  String get useTheApplicationForThoseAged18YearsAndOver {
    return Intl.message(
      'Use the application for those aged 18 years and over',
      name: 'useTheApplicationForThoseAged18YearsAndOver',
      desc: '',
      args: [],
    );
  }

  /// `Over 18 years old`
  String get over18YearsOld {
    return Intl.message(
      'Over 18 years old',
      name: 'over18YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `The application seeks to provide the highest levels \nof security and protection for all its users, and \nmembers who are not serious about marriage will be \nliquidated to provide the best quality`
  String get theApplicationSeeksToProvideTheHighestLevels {
    return Intl.message(
      'The application seeks to provide the highest levels \\nof security and protection for all its users, and \\nmembers who are not serious about marriage will be \\nliquidated to provide the best quality',
      name: 'theApplicationSeeksToProvideTheHighestLevels',
      desc: '',
      args: [],
    );
  }

  /// `Safety & protection`
  String get safetyProtection {
    return Intl.message(
      'Safety & protection',
      name: 'safetyProtection',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get read {
    return Intl.message(
      'Read',
      name: 'read',
      desc: '',
      args: [],
    );
  }

  /// `privacy and policy`
  String get privacyAndPolicy {
    return Intl.message(
      'privacy and policy',
      name: 'privacyAndPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please login to use the app`
  String get pleaseLoginToUseTheApp {
    return Intl.message(
      'Please login to use the app',
      name: 'pleaseLoginToUseTheApp',
      desc: '',
      args: [],
    );
  }

  /// `login with Email or Username...`
  String get loginWithEmailOrUsername {
    return Intl.message(
      'login with Email or Username...',
      name: 'loginWithEmailOrUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter password...`
  String get enterPassword {
    return Intl.message(
      'Enter password...',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get register {
    return Intl.message(
      'register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender {
    return Intl.message(
      'gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Hilike`
  String get welcomeToHilike {
    return Intl.message(
      'Welcome to Hilike',
      name: 'welcomeToHilike',
      desc: '',
      args: [],
    );
  }

  /// `Find the best and most suitable partner for \nmarriage`
  String get findTheBestAndMostSuitablePartner {
    return Intl.message(
      'Find the best and most suitable partner for \\nmarriage',
      name: 'findTheBestAndMostSuitablePartner',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Apple`
  String get logInWithApple {
    return Intl.message(
      'Log In with Apple',
      name: 'logInWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Google`
  String get logInWithGoogle {
    return Intl.message(
      'Log In with Google',
      name: 'logInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Facebook`
  String get logInWithFacebook {
    return Intl.message(
      'Log In with Facebook',
      name: 'logInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `I already have an account`
  String get iAlreadyHaveAnAccount {
    return Intl.message(
      'I already have an account',
      name: 'iAlreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `If you need help, please`
  String get ifYouNeedHelpPlease {
    return Intl.message(
      'If you need help, please',
      name: 'ifYouNeedHelpPlease',
      desc: '',
      args: [],
    );
  }

  /// `By registering you accept the terms of use and`
  String get byRegisteringYouAcceptTheTermsOfUse {
    return Intl.message(
      'By registering you accept the terms of use and',
      name: 'byRegisteringYouAcceptTheTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Liked you`
  String get likedYou {
    return Intl.message(
      'Liked you',
      name: 'likedYou',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `People liked you`
  String get peopleLikedYou {
    return Intl.message(
      'People liked you',
      name: 'peopleLikedYou',
      desc: '',
      args: [],
    );
  }

  /// `Chat with people who like you`
  String get chatWithPeopleWhoLikeYou {
    return Intl.message(
      'Chat with people who like you',
      name: 'chatWithPeopleWhoLikeYou',
      desc: '',
      args: [],
    );
  }

  /// `Gold`
  String get gold {
    return Intl.message(
      'Gold',
      name: 'gold',
      desc: '',
      args: [],
    );
  }

  /// `Find your match`
  String get findYourMatch {
    return Intl.message(
      'Find your match',
      name: 'findYourMatch',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to HiLike, please respect users and chat in \n a decent way for everyone.`
  String get welcomeToHilikePleaseRespectUsersAndChat {
    return Intl.message(
      'Welcome to HiLike, please respect users and chat in \\n a decent way for everyone.',
      name: 'welcomeToHilikePleaseRespectUsersAndChat',
      desc: '',
      args: [],
    );
  }

  /// `Vip`
  String get vip {
    return Intl.message(
      'Vip',
      name: 'vip',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Special people`
  String get specialPeople {
    return Intl.message(
      'Special people',
      name: 'specialPeople',
      desc: '',
      args: [],
    );
  }

  /// `Suggested People`
  String get suggestedPeople {
    return Intl.message(
      'Suggested People',
      name: 'suggestedPeople',
      desc: '',
      args: [],
    );
  }

  /// `We recommend that you complete\nyour personal page`
  String get weRecommendThatYouCompleteYourPersonalPage {
    return Intl.message(
      'We recommend that you complete\\nyour personal page',
      name: 'weRecommendThatYouCompleteYourPersonalPage',
      desc: '',
      args: [],
    );
  }

  /// `Most of the users are interested in seeing your profile complete all your data, so others can find you and upload your page.`
  String get mostOfTheUsersAreInterestedIn {
    return Intl.message(
      'Most of the users are interested in seeing your profile complete all your data, so others can find you and upload your page.',
      name: 'mostOfTheUsersAreInterestedIn',
      desc: '',
      args: [],
    );
  }

  /// `Continue now`
  String get continueNow {
    return Intl.message(
      'Continue now',
      name: 'continueNow',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `A user sent you a gift`
  String get aUserSentYouGift {
    return Intl.message(
      'A user sent you a gift',
      name: 'aUserSentYouGift',
      desc: '',
      args: [],
    );
  }

  /// `What kind of music do you like?`
  String get whatKindOfMusicDoYouLike {
    return Intl.message(
      'What kind of music do you like?',
      name: 'whatKindOfMusicDoYouLike',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `My photos`
  String get myPhotos {
    return Intl.message(
      'My photos',
      name: 'myPhotos',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get aboutMe {
    return Intl.message(
      'About me',
      name: 'aboutMe',
      desc: '',
      args: [],
    );
  }

  /// `Who am i looking for`
  String get iLookFor {
    return Intl.message(
      'Who am i looking for',
      name: 'iLookFor',
      desc: '',
      args: [],
    );
  }

  /// `Basic information`
  String get basicInformation {
    return Intl.message(
      'Basic information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInformation {
    return Intl.message(
      'Personal information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Shape`
  String get shape {
    return Intl.message(
      'Shape',
      name: 'shape',
      desc: '',
      args: [],
    );
  }

  /// `Origin Country`
  String get originCountry {
    return Intl.message(
      'Origin Country',
      name: 'originCountry',
      desc: '',
      args: [],
    );
  }

  /// `report`
  String get report {
    return Intl.message(
      'report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Search Filters`
  String get searchFilters {
    return Intl.message(
      'Search Filters',
      name: 'searchFilters',
      desc: '',
      args: [],
    );
  }

  /// `Filters for search`
  String get applyFiltersForSearch {
    return Intl.message(
      'Filters for search',
      name: 'applyFiltersForSearch',
      desc: '',
      args: [],
    );
  }

  /// `Here you can set up filters for better search`
  String get hereYouCanSetUpFiltersForBetterSearch {
    return Intl.message(
      'Here you can set up filters for better search',
      name: 'hereYouCanSetUpFiltersForBetterSearch',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Select your country`
  String get selectYourCountry {
    return Intl.message(
      'Select your country',
      name: 'selectYourCountry',
      desc: '',
      args: [],
    );
  }

  /// `Residence Country`
  String get residenceCountry {
    return Intl.message(
      'Residence Country',
      name: 'residenceCountry',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Not Specify`
  String get notSpecify {
    return Intl.message(
      'Not Specify',
      name: 'notSpecify',
      desc: '',
      args: [],
    );
  }

  /// `Religion`
  String get religion {
    return Intl.message(
      'Religion',
      name: 'religion',
      desc: '',
      args: [],
    );
  }

  /// `Marital status`
  String get socialType {
    return Intl.message(
      'Marital status',
      name: 'socialType',
      desc: '',
      args: [],
    );
  }

  /// `Type of marriage`
  String get typeOfMarriage {
    return Intl.message(
      'Type of marriage',
      name: 'typeOfMarriage',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Your job`
  String get yourJob {
    return Intl.message(
      'Your job',
      name: 'yourJob',
      desc: '',
      args: [],
    );
  }

  /// `Children`
  String get children {
    return Intl.message(
      'Children',
      name: 'children',
      desc: '',
      args: [],
    );
  }

  /// `Smoking`
  String get smoking {
    return Intl.message(
      'Smoking',
      name: 'smoking',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Upload an image`
  String get Uploadanimage {
    return Intl.message(
      'Upload an image',
      name: 'Uploadanimage',
      desc: '',
      args: [],
    );
  }

  /// `Upload image`
  String get Uploadimage {
    return Intl.message(
      'Upload image',
      name: 'Uploadimage',
      desc: '',
      args: [],
    );
  }

  /// `The user only wants to communicate with members who post their photos`
  String get Theuseronlywants {
    return Intl.message(
      'The user only wants to communicate with members who post their photos',
      name: 'Theuseronlywants',
      desc: '',
      args: [],
    );
  }

  /// `Skin color`
  String get skinColor {
    return Intl.message(
      'Skin color',
      name: 'skinColor',
      desc: '',
      args: [],
    );
  }

  /// `Body`
  String get body {
    return Intl.message(
      'Body',
      name: 'body',
      desc: '',
      args: [],
    );
  }

  /// `Signed out`
  String get Signedout {
    return Intl.message(
      'Signed out',
      name: 'Signedout',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully`
  String get Signed_in {
    return Intl.message(
      'Signed in successfully',
      name: 'Signed_in',
      desc: '',
      args: [],
    );
  }

  /// `Buy Coins`
  String get buyCoins {
    return Intl.message(
      'Buy Coins',
      name: 'buyCoins',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get Balance {
    return Intl.message(
      'Balance',
      name: 'Balance',
      desc: '',
      args: [],
    );
  }

  /// `Recharge Coins`
  String get RechargeCoins {
    return Intl.message(
      'Recharge Coins',
      name: 'RechargeCoins',
      desc: '',
      args: [],
    );
  }

  /// `Choose a package`
  String get choosePackage {
    return Intl.message(
      'Choose a package',
      name: 'choosePackage',
      desc: '',
      args: [],
    );
  }

  /// `Your Report sent succcessfully`
  String get reportdone {
    return Intl.message(
      'Your Report sent succcessfully',
      name: 'reportdone',
      desc: '',
      args: [],
    );
  }

  /// `Free trial 1 day`
  String get freeTrial {
    return Intl.message(
      'Free trial 1 day',
      name: 'freeTrial',
      desc: '',
      args: [],
    );
  }

  /// `Buy Gifts`
  String get buyGifts {
    return Intl.message(
      'Buy Gifts',
      name: 'buyGifts',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs2 {
    return Intl.message(
      'Contact us',
      name: 'contactUs2',
      desc: '',
      args: [],
    );
  }

  /// `Drinking`
  String get drink {
    return Intl.message(
      'Drinking',
      name: 'drink',
      desc: '',
      args: [],
    );
  }

  /// `Choose a gift alerts`
  String get chooseGiftAlerts {
    return Intl.message(
      'Choose a gift alerts',
      name: 'chooseGiftAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Choose a worthy gift and send it to the person you like\nSo that the gift appears as an alert on your message to \nattract people`
  String get chooseWorthyGiftAndSendIt {
    return Intl.message(
      'Choose a worthy gift and send it to the person you like\\nSo that the gift appears as an alert on your message to \\nattract people',
      name: 'chooseWorthyGiftAndSendIt',
      desc: '',
      args: [],
    );
  }

  /// `Choose a gift from the list`
  String get chooseGiftFromTheList {
    return Intl.message(
      'Choose a gift from the list',
      name: 'chooseGiftFromTheList',
      desc: '',
      args: [],
    );
  }

  /// `Pay 25 Coins`
  String get pay25Coins {
    return Intl.message(
      'Pay 25 Coins',
      name: 'pay25Coins',
      desc: '',
      args: [],
    );
  }

  /// `Send the gift`
  String get sendTheGift {
    return Intl.message(
      'Send the gift',
      name: 'sendTheGift',
      desc: '',
      args: [],
    );
  }

  /// `Not enough coins`
  String get notEnoughCoins {
    return Intl.message(
      'Not enough coins',
      name: 'notEnoughCoins',
      desc: '',
      args: [],
    );
  }

  /// `There are not enough coins in your account, \nplease top up your account`
  String get thereAreNotEnoughCoinsInYourAccount {
    return Intl.message(
      'There are not enough coins in your account, \nplease top up your account',
      name: 'thereAreNotEnoughCoinsInYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `BUY`
  String get buy {
    return Intl.message(
      'BUY',
      name: 'buy',
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

  /// `Gifts received`
  String get giftsReceived {
    return Intl.message(
      'Gifts received',
      name: 'giftsReceived',
      desc: '',
      args: [],
    );
  }

  /// `Gifts you received from people who like you.`
  String get giftsYouReceivedFromPeopleWhoLikeYou {
    return Intl.message(
      'Gifts you received from people who like you.',
      name: 'giftsYouReceivedFromPeopleWhoLikeYou',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get paymentMethods {
    return Intl.message(
      'Payment methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Choose payment methods`
  String get choosePaymentMethods {
    return Intl.message(
      'Choose payment methods',
      name: 'choosePaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Choose a convenient payment method for the service`
  String get chooseConvenientPaymentMethodForTheService {
    return Intl.message(
      'Choose a convenient payment method for the service',
      name: 'chooseConvenientPaymentMethodForTheService',
      desc: '',
      args: [],
    );
  }

  /// `Pay Via PayPal`
  String get payViaPaypal {
    return Intl.message(
      'Pay Via PayPal',
      name: 'payViaPaypal',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get Today {
    return Intl.message(
      'Today',
      name: 'Today',
      desc: '',
      args: [],
    );
  }

  /// `Pay Via Apple Store`
  String get payViaAppleStore {
    return Intl.message(
      'Pay Via Apple Store',
      name: 'payViaAppleStore',
      desc: '',
      args: [],
    );
  }

  /// `Pay Via Google Store`
  String get payViaGoogleStore {
    return Intl.message(
      'Pay Via Google Store',
      name: 'payViaGoogleStore',
      desc: '',
      args: [],
    );
  }

  /// `Pay now`
  String get payNow {
    return Intl.message(
      'Pay now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `Your payment is guaranteed by MyFatoorah`
  String get yourPaymentIsGuaranteedByMyfatoorah {
    return Intl.message(
      'Your payment is guaranteed by MyFatoorah',
      name: 'yourPaymentIsGuaranteedByMyfatoorah',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Search`
  String get advancedSearch {
    return Intl.message(
      'Advanced Search',
      name: 'advancedSearch',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited Chat`
  String get unlimitedChat {
    return Intl.message(
      'Unlimited Chat',
      name: 'unlimitedChat',
      desc: '',
      args: [],
    );
  }

  /// `Priority appearing at the top of the page`
  String get priorityAppearingAtTheTopOfThePage {
    return Intl.message(
      'Priority appearing at the top of the page',
      name: 'priorityAppearingAtTheTopOfThePage',
      desc: '',
      args: [],
    );
  }

  /// `Choose plan option`
  String get choosePlanOption {
    return Intl.message(
      'Choose plan option',
      name: 'choosePlanOption',
      desc: '',
      args: [],
    );
  }

  /// `There is no automatic renewal after purchase`
  String get thereIsNoAutomaticRenewalAfterPurchase {
    return Intl.message(
      'There is no automatic renewal after purchase',
      name: 'thereIsNoAutomaticRenewalAfterPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get months {
    return Intl.message(
      'Months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `SAVE 7%`
  String get save7 {
    return Intl.message(
      'SAVE 7%',
      name: 'save7',
      desc: '',
      args: [],
    );
  }

  /// `free trial 3 day`
  String get freeTrial3Day {
    return Intl.message(
      'free trial 3 day',
      name: 'freeTrial3Day',
      desc: '',
      args: [],
    );
  }

  /// `Appears at the top`
  String get appearsAtTheTop {
    return Intl.message(
      'Appears at the top',
      name: 'appearsAtTheTop',
      desc: '',
      args: [],
    );
  }

  /// `Priority appearing at the top of the chat`
  String get priorityAppearingAtTheTopOfTheChat {
    return Intl.message(
      'Priority appearing at the top of the chat',
      name: 'priorityAppearingAtTheTopOfTheChat',
      desc: '',
      args: [],
    );
  }

  /// `pay`
  String get pay {
    return Intl.message(
      'pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your data`
  String get pleaseEnterYourData {
    return Intl.message(
      'Please enter your data',
      name: 'pleaseEnterYourData',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mail...`
  String get enterYourMail {
    return Intl.message(
      'Enter your mail...',
      name: 'enterYourMail',
      desc: '',
      args: [],
    );
  }

  /// `Agree terms of use and privacy policy`
  String get agreeTermsOfUseAndPrivacyPolicy {
    return Intl.message(
      'Agree terms of use and privacy policy',
      name: 'agreeTermsOfUseAndPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Origin`
  String get origin {
    return Intl.message(
      'Origin',
      name: 'origin',
      desc: '',
      args: [],
    );
  }

  /// `Residence`
  String get residence {
    return Intl.message(
      'Residence',
      name: 'residence',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Missing picture`
  String get missingPicture {
    return Intl.message(
      'Missing picture',
      name: 'missingPicture',
      desc: '',
      args: [],
    );
  }

  /// `Your profile picture is missing. Please download one\nto get a better appearance`
  String get yourProfilePictureIsMissing {
    return Intl.message(
      'Your profile picture is missing. Please download one\\nto get a better appearance',
      name: 'yourProfilePictureIsMissing',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `You haven't any messages`
  String get youHaveNotAnyMessages {
    return Intl.message(
      'You haven\'t any messages',
      name: 'youHaveNotAnyMessages',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save changes`
  String get doYouWantToSaveChanges {
    return Intl.message(
      'Do you want to save changes',
      name: 'doYouWantToSaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Progress  70%`
  String get progress70 {
    return Intl.message(
      'Progress  70%',
      name: 'progress70',
      desc: '',
      args: [],
    );
  }

  /// `Who am i looking for`
  String get whoAmiLookingFor {
    return Intl.message(
      'Who am i looking for',
      name: 'whoAmiLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Other Photos:`
  String get otherPhotos {
    return Intl.message(
      'Other Photos:',
      name: 'otherPhotos',
      desc: '',
      args: [],
    );
  }

  /// `chat`
  String get chat {
    return Intl.message(
      'chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `I'm looking for`
  String get iAmLookingFor {
    return Intl.message(
      'I\'m looking for',
      name: 'iAmLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Submit a Report`
  String get submitReport {
    return Intl.message(
      'Submit a Report',
      name: 'submitReport',
      desc: '',
      args: [],
    );
  }

  /// `Choose the reason for submitting\na report`
  String get chooseTheReasonForSubmittingReport {
    return Intl.message(
      'Choose the reason for submitting\\na report',
      name: 'chooseTheReasonForSubmittingReport',
      desc: '',
      args: [],
    );
  }

  /// `Inappropriate messages`
  String get inappropriateMessages {
    return Intl.message(
      'Inappropriate messages',
      name: 'inappropriateMessages',
      desc: '',
      args: [],
    );
  }

  /// `Inappropriate photos`
  String get inappropriatePhotos {
    return Intl.message(
      'Inappropriate photos',
      name: 'inappropriatePhotos',
      desc: '',
      args: [],
    );
  }

  /// `Publish contact information`
  String get publishContactInformation {
    return Intl.message(
      'Publish contact information',
      name: 'publishContactInformation',
      desc: '',
      args: [],
    );
  }

  /// `Submit a dating request`
  String get submitDatingRequest {
    return Intl.message(
      'Submit a dating request',
      name: 'submitDatingRequest',
      desc: '',
      args: [],
    );
  }

  /// `Fraud and money transfer request`
  String get fraudAndMoneyTransferRequest {
    return Intl.message(
      'Fraud and money transfer request',
      name: 'fraudAndMoneyTransferRequest',
      desc: '',
      args: [],
    );
  }

  /// `Providing sexual services`
  String get providingSexualServices {
    return Intl.message(
      'Providing sexual services',
      name: 'providingSexualServices',
      desc: '',
      args: [],
    );
  }

  /// `Photo of someone else`
  String get photoOfSomeoneElse {
    return Intl.message(
      'Photo of someone else',
      name: 'photoOfSomeoneElse',
      desc: '',
      args: [],
    );
  }

  /// `Under 18 years old`
  String get under18YearsOld {
    return Intl.message(
      'Under 18 years old',
      name: 'under18YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Search feed:`
  String get searchFeed {
    return Intl.message(
      'Search feed:',
      name: 'searchFeed',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Online now`
  String get onlineNow {
    return Intl.message(
      'Online now',
      name: 'onlineNow',
      desc: '',
      args: [],
    );
  }

  /// `Select users who are online now or within 3 hours`
  String get selectUsersWhoAreOnlineNow {
    return Intl.message(
      'Select users who are online now or within 3 hours',
      name: 'selectUsersWhoAreOnlineNow',
      desc: '',
      args: [],
    );
  }

  /// `With photo`
  String get withPhoto {
    return Intl.message(
      'With photo',
      name: 'withPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Select only users near me`
  String get selectOnlyUsersNearMe {
    return Intl.message(
      'Select only users near me',
      name: 'selectOnlyUsersNearMe',
      desc: '',
      args: [],
    );
  }

  /// `Select only profiles with photos`
  String get selectOnlyUsersWithPhoto {
    return Intl.message(
      'Select only profiles with photos',
      name: 'selectOnlyUsersWithPhoto',
      desc: '',
      args: [],
    );
  }

  /// `You blocked this contact. Tap to unblock.`
  String get Youblockedthiscontact {
    return Intl.message(
      'You blocked this contact. Tap to unblock.',
      name: 'Youblockedthiscontact',
      desc: '',
      args: [],
    );
  }

  /// `Nearby`
  String get nearby {
    return Intl.message(
      'Nearby',
      name: 'nearby',
      desc: '',
      args: [],
    );
  }

  /// `Select only users near me`
  String get fromTheSameCountry {
    return Intl.message(
      'Select only users near me',
      name: 'fromTheSameCountry',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get km {
    return Intl.message(
      'km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Last Visit`
  String get lastVisit {
    return Intl.message(
      'Last Visit',
      name: 'lastVisit',
      desc: '',
      args: [],
    );
  }

  /// `New People`
  String get newPeople {
    return Intl.message(
      'New People',
      name: 'newPeople',
      desc: '',
      args: [],
    );
  }

  /// `Share to ...`
  String get shareTo {
    return Intl.message(
      'Share to ...',
      name: 'shareTo',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get block {
    return Intl.message(
      'Block',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Something is wrong`
  String get somethingIsWrong {
    return Intl.message(
      'Something is wrong',
      name: 'somethingIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `liked`
  String get liked {
    return Intl.message(
      'liked',
      name: 'liked',
      desc: '',
      args: [],
    );
  }

  /// `General info`
  String get generalInfo {
    return Intl.message(
      'General info',
      name: 'generalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Personal info`
  String get personalInfo {
    return Intl.message(
      'Personal info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `MinAgo`
  String get MinAgo {
    return Intl.message(
      'MinAgo',
      name: 'MinAgo',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get Km {
    return Intl.message(
      'Km',
      name: 'Km',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get Years {
    return Intl.message(
      'Years',
      name: 'Years',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get Months {
    return Intl.message(
      'Months',
      name: 'Months',
      desc: '',
      args: [],
    );
  }

  /// `Connection failed`
  String get connectionFailed {
    return Intl.message(
      'Connection failed',
      name: 'connectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get fieldRequired {
    return Intl.message(
      'Field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone`
  String get invalidPhone {
    return Intl.message(
      'Invalid phone',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `The name must only contain letters, numbers, dashes and underscores.`
  String get nameRegExValidation {
    return Intl.message(
      'The name must only contain letters, numbers, dashes and underscores.',
      name: 'nameRegExValidation',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `You should agree terms of use and privacy policy first`
  String get youShouldAgreeTermsToFirst {
    return Intl.message(
      'You should agree terms of use and privacy policy first',
      name: 'youShouldAgreeTermsToFirst',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Please select your date of birth !!`
  String get pleaseSelectDob {
    return Intl.message(
      'Please select your date of birth !!',
      name: 'pleaseSelectDob',
      desc: '',
      args: [],
    );
  }

  /// `Please select your origin country !!`
  String get pleaseSelectOriginCountry {
    return Intl.message(
      'Please select your origin country !!',
      name: 'pleaseSelectOriginCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please select your residence country !!`
  String get pleaseSelectResidenceCountry {
    return Intl.message(
      'Please select your residence country !!',
      name: 'pleaseSelectResidenceCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter your origin country...`
  String get EnterOriginCountry {
    return Intl.message(
      'Enter your origin country...',
      name: 'EnterOriginCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter your residence country...`
  String get EnterResidenceCountry {
    return Intl.message(
      'Enter your residence country...',
      name: 'EnterResidenceCountry',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password doesn\'t match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 6 letters`
  String get passwordShouldBeAtLeast6Letters {
    return Intl.message(
      'Password should be at least 6 letters',
      name: 'passwordShouldBeAtLeast6Letters',
      desc: '',
      args: [],
    );
  }

  /// `HiLike`
  String get hiLike {
    return Intl.message(
      'HiLike',
      name: 'hiLike',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search_ {
    return Intl.message(
      'Search...',
      name: 'search_',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location for getting the nearest people`
  String get please_enable_location {
    return Intl.message(
      'Please enable location for getting the nearest people',
      name: 'please_enable_location',
      desc: '',
      args: [],
    );
  }

  /// `Permissions denied, Please enable it from app settings`
  String get location_permission_denied_forever {
    return Intl.message(
      'Permissions denied, Please enable it from app settings',
      name: 'location_permission_denied_forever',
      desc: '',
      args: [],
    );
  }

  /// `Can't find nearest people without getting your current location`
  String get location_permission_denied {
    return Intl.message(
      'Can\'t find nearest people without getting your current location',
      name: 'location_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Go to location settings`
  String get open_location_settings {
    return Intl.message(
      'Go to location settings',
      name: 'open_location_settings',
      desc: '',
      args: [],
    );
  }

  /// `Go to app settings`
  String get open_app_settings {
    return Intl.message(
      'Go to app settings',
      name: 'open_app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Allow location access`
  String get re_request_location_permissions {
    return Intl.message(
      'Allow location access',
      name: 're_request_location_permissions',
      desc: '',
      args: [],
    );
  }

  /// `We can't access your location, please try again`
  String get get_location_timeout {
    return Intl.message(
      'We can\'t access your location, please try again',
      name: 'get_location_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search__ {
    return Intl.message(
      'Search',
      name: 'search__',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout ?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout ?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `account`
  String get account {
    return Intl.message(
      'account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get job {
    return Intl.message(
      'Job',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `Marriage type`
  String get marriageType {
    return Intl.message(
      'Marriage type',
      name: 'marriageType',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `CM`
  String get cm {
    return Intl.message(
      'CM',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Type here`
  String get typeHere {
    return Intl.message(
      'Type here',
      name: 'typeHere',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile !!`
  String get failedUpdateProfile {
    return Intl.message(
      'Failed to update profile !!',
      name: 'failedUpdateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `My account is visible to everyone`
  String get myAccountIsVisibleToEveryone {
    return Intl.message(
      'My account is visible to everyone',
      name: 'myAccountIsVisibleToEveryone',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Reason`
  String get pleaseSelectReason {
    return Intl.message(
      'Please Select Reason',
      name: 'pleaseSelectReason',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Reason...`
  String get pleaseEnterReason {
    return Intl.message(
      'Please Enter Your Reason...',
      name: 'pleaseEnterReason',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to unblock`
  String get doYouWantToUnblock {
    return Intl.message(
      'Do you want to unblock',
      name: 'doYouWantToUnblock',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to block`
  String get doYouWantToBlock {
    return Intl.message(
      'Do you want to block',
      name: 'doYouWantToBlock',
      desc: '',
      args: [],
    );
  }

  /// `Recharge`
  String get recharge {
    return Intl.message(
      'Recharge',
      name: 'recharge',
      desc: '',
      args: [],
    );
  }

  /// `You have to choose payment method first`
  String get youHaveToSelectPaymentMeathodFirst {
    return Intl.message(
      'You have to choose payment method first',
      name: 'youHaveToSelectPaymentMeathodFirst',
      desc: '',
      args: [],
    );
  }

  /// `You have to fill the required fields`
  String get youhavetofilltherequiderfilde {
    return Intl.message(
      'You have to fill the required fields',
      name: 'youhavetofilltherequiderfilde',
      desc: '',
      args: [],
    );
  }

  /// `Pick Your Age`
  String get PickYourAge {
    return Intl.message(
      'Pick Your Age',
      name: 'PickYourAge',
      desc: '',
      args: [],
    );
  }

  /// `Send message to us:`
  String get Sendmessagetous {
    return Intl.message(
      'Send message to us:',
      name: 'Sendmessagetous',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'WelcometoHiLike!Ifyouhoveanyproblem' key

  /// `Please follow the rules \nso that everyone can have \na good time at Hi Like`
  String get rule1 {
    return Intl.message(
      'Please follow the rules \nso that everyone can have \na good time at Hi Like',
      name: 'rule1',
      desc: '',
      args: [],
    );
  }

  /// `Remember that the following \nis fully prohibited`
  String get rule2 {
    return Intl.message(
      'Remember that the following \nis fully prohibited',
      name: 'rule2',
      desc: '',
      args: [],
    );
  }

  /// `Hi like is not a dating \napplication and all members \nare here to search for \nlegal marriage only`
  String get rule3 {
    return Intl.message(
      'Hi like is not a dating \napplication and all members \nare here to search for \nlegal marriage only',
      name: 'rule3',
      desc: '',
      args: [],
    );
  }

  /// `Do not add Pictures that \nare offensive to modesty \nand public taste`
  String get rule4 {
    return Intl.message(
      'Do not add Pictures that \nare offensive to modesty \nand public taste',
      name: 'rule4',
      desc: '',
      args: [],
    );
  }

  /// `Not offend or ask for dating \nor display external means of \ncommunication in your profile`
  String get rule5 {
    return Intl.message(
      'Not offend or ask for dating \nor display external means of \ncommunication in your profile',
      name: 'rule5',
      desc: '',
      args: [],
    );
  }

  /// `I accept`
  String get accept {
    return Intl.message(
      'I accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `You have a notice from the admin`
  String get notic {
    return Intl.message(
      'You have a notice from the admin',
      name: 'notic',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get Tickets {
    return Intl.message(
      'Tickets',
      name: 'Tickets',
      desc: '',
      args: [],
    );
  }

  /// `No blocked people`
  String get noblocked {
    return Intl.message(
      'No blocked people',
      name: 'noblocked',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any messages`
  String get donthaveanymessages {
    return Intl.message(
      'You don`t have any messages',
      name: 'donthaveanymessages',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any likes`
  String get donthaveanyfans {
    return Intl.message(
      'You don`t have any likes',
      name: 'donthaveanyfans',
      desc: '',
      args: [],
    );
  }

  /// `Search did not return any results, please \n check the correctness of the input or try again`
  String get Searchdidnot {
    return Intl.message(
      'Search did not return any results, please \n check the correctness of the input or try again',
      name: 'Searchdidnot',
      desc: '',
      args: [],
    );
  }

  /// `Please Try Again`
  String get PleaseTryAgain {
    return Intl.message(
      'Please Try Again',
      name: 'PleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Successful Upgrade`
  String get upgradePlanScuss {
    return Intl.message(
      'Successful Upgrade',
      name: 'upgradePlanScuss',
      desc: '',
      args: [],
    );
  }

  /// `Successful Payment`
  String get payPlanScuss {
    return Intl.message(
      'Successful Payment',
      name: 'payPlanScuss',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Your payment is guaranteed by`
  String get garnted {
    return Intl.message(
      'Your payment is guaranteed by',
      name: 'garnted',
      desc: '',
      args: [],
    );
  }

  /// `Liked you`
  String get fans {
    return Intl.message(
      'Liked you',
      name: 'fans',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePage {
    return Intl.message(
      'Profile',
      name: 'profilePage',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get Free {
    return Intl.message(
      'Free',
      name: 'Free',
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
