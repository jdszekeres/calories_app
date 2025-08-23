import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_zh.dart';

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
    Locale('es'),
    Locale('hi'),
    Locale('zh'),
  ];

  /// No description provided for @aiCredits.
  ///
  /// In en, this message translates to:
  /// **'AI Credits'**
  String get aiCredits;

  /// No description provided for @aiCreditDescription.
  ///
  /// In en, this message translates to:
  /// **'You need AI credits to use AI food analysis. Click here to gain 5 more by watching an ad.'**
  String get aiCreditDescription;

  /// No description provided for @creditCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No Credits} =1{1 Credit} other{{count} Credits}}'**
  String creditCount(num count);

  /// No description provided for @calorieGoals.
  ///
  /// In en, this message translates to:
  /// **'Calorie Goals'**
  String get calorieGoals;

  /// No description provided for @macroNutrientGoals.
  ///
  /// In en, this message translates to:
  /// **'Macro Nutrient Goals'**
  String get macroNutrientGoals;

  /// No description provided for @vitaminGoals.
  ///
  /// In en, this message translates to:
  /// **'Vitamin Goals'**
  String get vitaminGoals;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @setGoal.
  ///
  /// In en, this message translates to:
  /// **'Set Goal'**
  String get setGoal;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input'**
  String get invalidInput;

  /// No description provided for @fillForm.
  ///
  /// In en, this message translates to:
  /// **'Please fill out all form fields.'**
  String get fillForm;

  /// No description provided for @dailyGoals.
  ///
  /// In en, this message translates to:
  /// **'Daily Goals'**
  String get dailyGoals;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noGoalsFound.
  ///
  /// In en, this message translates to:
  /// **'No goals found. Please set your goals in settings.'**
  String get noGoalsFound;

  /// No description provided for @myMeals.
  ///
  /// In en, this message translates to:
  /// **'My Meals'**
  String get myMeals;

  /// No description provided for @noMealsFound.
  ///
  /// In en, this message translates to:
  /// **'No meals found. Please add some meals.'**
  String get noMealsFound;

  /// No description provided for @addMeal.
  ///
  /// In en, this message translates to:
  /// **'Add Meal'**
  String get addMeal;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @enterGoal.
  ///
  /// In en, this message translates to:
  /// **'Enter your goal'**
  String get enterGoal;

  /// No description provided for @setGoalFor.
  ///
  /// In en, this message translates to:
  /// **'Set goal for {foodType}'**
  String setGoalFor(Object foodType);

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @step1_2.
  ///
  /// In en, this message translates to:
  /// **'Step 1/2'**
  String get step1_2;

  /// No description provided for @step2_2.
  ///
  /// In en, this message translates to:
  /// **'Step 2/2'**
  String get step2_2;

  /// No description provided for @tellUs.
  ///
  /// In en, this message translates to:
  /// **'Tell us more about yourself'**
  String get tellUs;

  /// No description provided for @tellUsExplain.
  ///
  /// In en, this message translates to:
  /// **'This helps us calculate your daily calorie goals'**
  String get tellUsExplain;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @useImperial.
  ///
  /// In en, this message translates to:
  /// **'Use imperial units'**
  String get useImperial;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weight;

  /// No description provided for @weightImperial.
  ///
  /// In en, this message translates to:
  /// **'Weight (lb)'**
  String get weightImperial;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get height;

  /// No description provided for @heightImperial.
  ///
  /// In en, this message translates to:
  /// **'Height (in)'**
  String get heightImperial;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get activityLevel;

  /// No description provided for @sedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary (little or no exercise)'**
  String get sedentary;

  /// No description provided for @lightlyActive.
  ///
  /// In en, this message translates to:
  /// **'Lightly Active (light exercise 1-3 days/week)'**
  String get lightlyActive;

  /// No description provided for @moderatelyActive.
  ///
  /// In en, this message translates to:
  /// **'Moderately Active (moderate exercise 3-5 days/week)'**
  String get moderatelyActive;

  /// No description provided for @veryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active (hard exercise 6-7 days a week)'**
  String get veryActive;

  /// No description provided for @extraActive.
  ///
  /// In en, this message translates to:
  /// **'Extra Active (very hard exercise, physical job, or training twice a day)'**
  String get extraActive;

  /// No description provided for @completeSignUp.
  ///
  /// In en, this message translates to:
  /// **'Complete Sign Up'**
  String get completeSignUp;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get noAccount;

  /// No description provided for @tryAnon.
  ///
  /// In en, this message translates to:
  /// **'Try without an account'**
  String get tryAnon;

  /// No description provided for @downloadApp.
  ///
  /// In en, this message translates to:
  /// **'Download App'**
  String get downloadApp;

  /// No description provided for @webAdvertisementTitle.
  ///
  /// In en, this message translates to:
  /// **'We cannot offer advertisements on the web'**
  String get webAdvertisementTitle;

  /// No description provided for @mobileAdvertisementTitle.
  ///
  /// In en, this message translates to:
  /// **'No advertisements available'**
  String get mobileAdvertisementTitle;

  /// No description provided for @useMobileAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Please use the mobile app to view ads'**
  String get useMobileAppMessage;

  /// No description provided for @supportMeMessage.
  ///
  /// In en, this message translates to:
  /// **'or consider supporting me via BuyMeACoffee.'**
  String get supportMeMessage;

  /// No description provided for @supportMe.
  ///
  /// In en, this message translates to:
  /// **'Support Me'**
  String get supportMe;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie Tracker'**
  String get appTitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get alreadyHaveAccount;

  /// No description provided for @creatingAnon.
  ///
  /// In en, this message translates to:
  /// **'Creating an Anonymous Account'**
  String get creatingAnon;

  /// No description provided for @creatingAnonExplain.
  ///
  /// In en, this message translates to:
  /// **'We still need some information to set up your profile and calculate your goals.'**
  String get creatingAnonExplain;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age'**
  String get invalidAge;

  /// No description provided for @invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid weight'**
  String get invalidWeight;

  /// No description provided for @invalidHeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid height'**
  String get invalidHeight;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data: {message}'**
  String errorLoadingData(Object message);

  /// No description provided for @errorLoadingGoals.
  ///
  /// In en, this message translates to:
  /// **'Error loading goals: {message}'**
  String errorLoadingGoals(Object message);

  /// No description provided for @editNutritionFacts.
  ///
  /// In en, this message translates to:
  /// **'Edit nutrition facts'**
  String get editNutritionFacts;

  /// No description provided for @nutritionFacts.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Facts'**
  String get nutritionFacts;

  /// No description provided for @servingSize.
  ///
  /// In en, this message translates to:
  /// **'Serving size'**
  String get servingSize;

  /// No description provided for @servingSizeValue.
  ///
  /// In en, this message translates to:
  /// **'Serving size {servingSize}'**
  String servingSizeValue(Object servingSize);

  /// No description provided for @youAteServings.
  ///
  /// In en, this message translates to:
  /// **'You ate {servings} servings'**
  String youAteServings(Object servings);

  /// No description provided for @yourIntake.
  ///
  /// In en, this message translates to:
  /// **'Your Intake'**
  String get yourIntake;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @homePageWidgets.
  ///
  /// In en, this message translates to:
  /// **'Home Page Widgets'**
  String get homePageWidgets;

  /// No description provided for @selectHomeWidgetsDescription.
  ///
  /// In en, this message translates to:
  /// **'Select what goals should appear on the homescreen'**
  String get selectHomeWidgetsDescription;

  /// No description provided for @selectHomePageWidgets.
  ///
  /// In en, this message translates to:
  /// **'Select Home Page Widgets'**
  String get selectHomePageWidgets;

  /// No description provided for @homePageWidgetsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Home page widgets updated successfully'**
  String get homePageWidgetsUpdated;

  /// No description provided for @nutritionGoals.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Goals'**
  String get nutritionGoals;

  /// No description provided for @updateHealthInformation.
  ///
  /// In en, this message translates to:
  /// **'Update health information'**
  String get updateHealthInformation;

  /// No description provided for @resetNutritionGoals.
  ///
  /// In en, this message translates to:
  /// **'Reset Nutrition Goals'**
  String get resetNutritionGoals;

  /// No description provided for @nutritionGoalsReset.
  ///
  /// In en, this message translates to:
  /// **'Nutrition goals reset successfully'**
  String get nutritionGoalsReset;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @createAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'Want to keep using our app? Create an account to save your data.'**
  String get createAccountDesc;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmBody;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get accountDeleted;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperial;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @updateHealthInformationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Health information updated successfully!'**
  String get updateHealthInformationSuccess;

  /// No description provided for @couldNotLoadUserProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not load user profile'**
  String get couldNotLoadUserProfile;

  /// No description provided for @errorSavingHealthInformation.
  ///
  /// In en, this message translates to:
  /// **'Error saving health information: {message}'**
  String errorSavingHealthInformation(Object message);

  /// No description provided for @createAccountTagline.
  ///
  /// In en, this message translates to:
  /// **'Save your data and sync across devices'**
  String get createAccountTagline;

  /// No description provided for @createAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get createAccountSuccess;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitLbs.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get unitLbs;

  /// No description provided for @unitCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCm;

  /// No description provided for @unitFt.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get unitFt;

  /// No description provided for @unitIn.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get unitIn;

  /// No description provided for @unitKcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get unitKcal;

  /// No description provided for @searchFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Food'**
  String get searchFoodTitle;

  /// No description provided for @searchForProducts.
  ///
  /// In en, this message translates to:
  /// **'Search for products'**
  String get searchForProducts;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @errorSearchingProducts.
  ///
  /// In en, this message translates to:
  /// **'Error searching products: {message}'**
  String errorSearchingProducts(Object message);

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(Object message);

  /// No description provided for @nutritionFactsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Nutrition facts updated!'**
  String get nutritionFactsUpdated;

  /// No description provided for @scanBarcodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get scanBarcodeTitle;

  /// No description provided for @mealDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Details'**
  String get mealDetailsTitle;

  /// No description provided for @aiNutritionAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Nutrition Analysis'**
  String get aiNutritionAnalysisTitle;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @aiPoweredNutritionAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Nutrition Analysis'**
  String get aiPoweredNutritionAnalysis;

  /// No description provided for @aiAnalysisDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload a photo of your meal and let our AI analyze its nutritional content instantly'**
  String get aiAnalysisDescription;

  /// No description provided for @whatAiCanIdentify.
  ///
  /// In en, this message translates to:
  /// **'What our AI can identify:'**
  String get whatAiCanIdentify;

  /// No description provided for @foodIdentification.
  ///
  /// In en, this message translates to:
  /// **'Food identification'**
  String get foodIdentification;

  /// No description provided for @portionEstimation.
  ///
  /// In en, this message translates to:
  /// **'Portion estimation'**
  String get portionEstimation;

  /// No description provided for @calorieCalculation.
  ///
  /// In en, this message translates to:
  /// **'Calorie calculation'**
  String get calorieCalculation;

  /// No description provided for @macroMicronutrients.
  ///
  /// In en, this message translates to:
  /// **'Macro & micronutrients'**
  String get macroMicronutrients;

  /// No description provided for @ingredientBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Ingredient breakdown'**
  String get ingredientBreakdown;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @aiTipMessage.
  ///
  /// In en, this message translates to:
  /// **'Tip: For best results, take a clear photo with good lighting and include the entire meal in frame.'**
  String get aiTipMessage;

  /// No description provided for @failedToAnalyzeImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to analyze image'**
  String get failedToAnalyzeImage;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @carbohydrates.
  ///
  /// In en, this message translates to:
  /// **'Carbohydrates'**
  String get carbohydrates;

  /// No description provided for @fiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get fiber;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get protein;

  /// No description provided for @fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get fat;

  /// No description provided for @sugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get sugar;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @vitaminA.
  ///
  /// In en, this message translates to:
  /// **'Vitamin A'**
  String get vitaminA;

  /// No description provided for @vitaminD.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D'**
  String get vitaminD;

  /// No description provided for @vitaminE.
  ///
  /// In en, this message translates to:
  /// **'Vitamin E'**
  String get vitaminE;

  /// No description provided for @vitaminK.
  ///
  /// In en, this message translates to:
  /// **'Vitamin K'**
  String get vitaminK;

  /// No description provided for @vitaminC.
  ///
  /// In en, this message translates to:
  /// **'Vitamin C'**
  String get vitaminC;

  /// No description provided for @thiamin.
  ///
  /// In en, this message translates to:
  /// **'Thiamin'**
  String get thiamin;

  /// No description provided for @riboflavin.
  ///
  /// In en, this message translates to:
  /// **'Riboflavin'**
  String get riboflavin;

  /// No description provided for @niacin.
  ///
  /// In en, this message translates to:
  /// **'Niacin'**
  String get niacin;

  /// No description provided for @pantothenicAcid.
  ///
  /// In en, this message translates to:
  /// **'Pantothenic Acid'**
  String get pantothenicAcid;

  /// No description provided for @vitaminB6.
  ///
  /// In en, this message translates to:
  /// **'Vitamin B6'**
  String get vitaminB6;

  /// No description provided for @folate.
  ///
  /// In en, this message translates to:
  /// **'Folate'**
  String get folate;

  /// No description provided for @vitaminB12.
  ///
  /// In en, this message translates to:
  /// **'Vitamin B12'**
  String get vitaminB12;

  /// No description provided for @choline.
  ///
  /// In en, this message translates to:
  /// **'Choline'**
  String get choline;

  /// No description provided for @calcium.
  ///
  /// In en, this message translates to:
  /// **'Calcium'**
  String get calcium;

  /// No description provided for @chlorine.
  ///
  /// In en, this message translates to:
  /// **'Chlorine'**
  String get chlorine;

  /// No description provided for @copper.
  ///
  /// In en, this message translates to:
  /// **'Copper'**
  String get copper;

  /// No description provided for @fluoride.
  ///
  /// In en, this message translates to:
  /// **'Fluoride'**
  String get fluoride;

  /// No description provided for @iodine.
  ///
  /// In en, this message translates to:
  /// **'Iodine'**
  String get iodine;

  /// No description provided for @iron.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get iron;

  /// No description provided for @magnesium.
  ///
  /// In en, this message translates to:
  /// **'Magnesium'**
  String get magnesium;

  /// No description provided for @manganese.
  ///
  /// In en, this message translates to:
  /// **'Manganese'**
  String get manganese;

  /// No description provided for @molybdenum.
  ///
  /// In en, this message translates to:
  /// **'Molybdenum'**
  String get molybdenum;

  /// No description provided for @phosphorus.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus'**
  String get phosphorus;

  /// No description provided for @potassium.
  ///
  /// In en, this message translates to:
  /// **'Potassium'**
  String get potassium;

  /// No description provided for @selenium.
  ///
  /// In en, this message translates to:
  /// **'Selenium'**
  String get selenium;

  /// No description provided for @sodium.
  ///
  /// In en, this message translates to:
  /// **'Sodium'**
  String get sodium;

  /// No description provided for @zinc.
  ///
  /// In en, this message translates to:
  /// **'Zinc'**
  String get zinc;

  /// No description provided for @loadingCredits.
  ///
  /// In en, this message translates to:
  /// **'Loading credits...'**
  String get loadingCredits;

  /// No description provided for @insufficientCredits.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Credits'**
  String get insufficientCredits;

  /// No description provided for @insufficientCreditsMessage.
  ///
  /// In en, this message translates to:
  /// **'You need at least 1 credit to use AI analysis. You currently have {credits} credits. You can earn more credits by watching ads in the Settings page.'**
  String insufficientCreditsMessage(Object credits);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @goToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get goToSettings;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get chinese;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिंदी'**
  String get hindi;

  /// No description provided for @languageChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully!'**
  String get languageChangedSuccessfully;
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
      <String>['ar', 'en', 'es', 'hi', 'zh'].contains(locale.languageCode);

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
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
