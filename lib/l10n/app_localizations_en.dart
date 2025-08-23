// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aiCredits => 'AI Credits';

  @override
  String get aiCreditDescription =>
      'You need AI credits to use AI food analysis. Click here to gain 5 more by watching an ad.';

  @override
  String creditCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Credits',
      one: '1 Credit',
      zero: 'No Credits',
    );
    return '$_temp0';
  }

  @override
  String get calorieGoals => 'Calorie Goals';

  @override
  String get macroNutrientGoals => 'Macro Nutrient Goals';

  @override
  String get vitaminGoals => 'Vitamin Goals';

  @override
  String get cancel => 'Cancel';

  @override
  String get setGoal => 'Set Goal';

  @override
  String get invalidInput => 'Invalid input';

  @override
  String get fillForm => 'Please fill out all form fields.';

  @override
  String get dailyGoals => 'Daily Goals';

  @override
  String get retry => 'Retry';

  @override
  String get noGoalsFound =>
      'No goals found. Please set your goals in settings.';

  @override
  String get myMeals => 'My Meals';

  @override
  String get noMealsFound => 'No meals found. Please add some meals.';

  @override
  String get addMeal => 'Add Meal';

  @override
  String get reAddMeal => 'Re-add Meal';

  @override
  String get goal => 'Goal';

  @override
  String get enterGoal => 'Enter your goal';

  @override
  String setGoalFor(Object foodType) {
    return 'Set goal for $foodType';
  }

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get next => 'Next';

  @override
  String get createAccount => 'Create Account';

  @override
  String get step1_2 => 'Step 1/2';

  @override
  String get step2_2 => 'Step 2/2';

  @override
  String get tellUs => 'Tell us more about yourself';

  @override
  String get tellUsExplain =>
      'This helps us calculate your daily calorie goals';

  @override
  String get age => 'Age';

  @override
  String get useImperial => 'Use imperial units';

  @override
  String get weight => 'Weight (kg)';

  @override
  String get weightImperial => 'Weight (lb)';

  @override
  String get height => 'Height (cm)';

  @override
  String get heightImperial => 'Height (in)';

  @override
  String get sex => 'Sex';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get activityLevel => 'Activity Level';

  @override
  String get sedentary => 'Sedentary (little or no exercise)';

  @override
  String get lightlyActive => 'Lightly Active (light exercise 1-3 days/week)';

  @override
  String get moderatelyActive =>
      'Moderately Active (moderate exercise 3-5 days/week)';

  @override
  String get veryActive => 'Very Active (hard exercise 6-7 days a week)';

  @override
  String get extraActive =>
      'Extra Active (very hard exercise, physical job, or training twice a day)';

  @override
  String get completeSignUp => 'Complete Sign Up';

  @override
  String get back => 'Back';

  @override
  String get signIn => 'Sign In';

  @override
  String get noAccount => 'Don\'t have an account? Sign Up';

  @override
  String get tryAnon => 'Try without an account';

  @override
  String get downloadApp => 'Download App';

  @override
  String get webAdvertisementTitle =>
      'We cannot offer advertisements on the web';

  @override
  String get mobileAdvertisementTitle => 'No advertisements available';

  @override
  String get useMobileAppMessage => 'Please use the mobile app to view ads';

  @override
  String get supportMeMessage => 'or consider supporting me via BuyMeACoffee.';

  @override
  String get supportMe => 'Support Me';

  @override
  String get appTitle => 'Calorie Tracker';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';

  @override
  String get creatingAnon => 'Creating an Anonymous Account';

  @override
  String get creatingAnonExplain =>
      'We still need some information to set up your profile and calculate your goals.';

  @override
  String get pleaseFillAllFields => 'Please fill in all fields';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters long';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidAge => 'Please enter a valid age';

  @override
  String get invalidWeight => 'Please enter a valid weight';

  @override
  String get invalidHeight => 'Please enter a valid height';

  @override
  String errorLoadingData(Object message) {
    return 'Error loading data: $message';
  }

  @override
  String errorLoadingGoals(Object message) {
    return 'Error loading goals: $message';
  }

  @override
  String get editNutritionFacts => 'Edit nutrition facts';

  @override
  String get nutritionFacts => 'Nutrition Facts';

  @override
  String get servingSize => 'Serving size';

  @override
  String servingSizeValue(Object servingSize) {
    return 'Serving size $servingSize';
  }

  @override
  String get servingCount => 'Number of Servings';

  @override
  String youAteServings(Object servings) {
    return 'You ate $servings servings';
  }

  @override
  String get yourIntake => 'Your Intake';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get save => 'Save';

  @override
  String get confirm => 'Confirm';

  @override
  String get settings => 'Settings';

  @override
  String get general => 'General';

  @override
  String get homePageWidgets => 'Home Page Widgets';

  @override
  String get selectHomeWidgetsDescription =>
      'Select what goals should appear on the homescreen';

  @override
  String get selectHomePageWidgets => 'Select Home Page Widgets';

  @override
  String get homePageWidgetsUpdated => 'Home page widgets updated successfully';

  @override
  String get nutritionGoals => 'Nutrition Goals';

  @override
  String get updateHealthInformation => 'Update health information';

  @override
  String get resetNutritionGoals => 'Reset Nutrition Goals';

  @override
  String get nutritionGoalsReset => 'Nutrition goals reset successfully';

  @override
  String get account => 'Account';

  @override
  String get createAccountDesc =>
      'Want to keep using our app? Create an account to save your data.';

  @override
  String get signOut => 'Sign Out';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAccountConfirmTitle => 'Delete Account';

  @override
  String get deleteAccountConfirmBody =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get accountDeleted => 'Account deleted successfully';

  @override
  String get metric => 'Metric';

  @override
  String get imperial => 'Imperial';

  @override
  String get years => 'years';

  @override
  String get saving => 'Saving...';

  @override
  String get updateHealthInformationSuccess =>
      'Health information updated successfully!';

  @override
  String get couldNotLoadUserProfile => 'Could not load user profile';

  @override
  String errorSavingHealthInformation(Object message) {
    return 'Error saving health information: $message';
  }

  @override
  String get createAccountTagline => 'Save your data and sync across devices';

  @override
  String get createAccountSuccess => 'Account created successfully';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitCm => 'cm';

  @override
  String get unitFt => 'ft';

  @override
  String get unitIn => 'in';

  @override
  String get unitKcal => 'kcal';

  @override
  String get searchFoodTitle => 'Search Food';

  @override
  String get searchForProducts => 'Search for products';

  @override
  String get noResultsFound => 'No results found';

  @override
  String errorSearchingProducts(Object message) {
    return 'Error searching products: $message';
  }

  @override
  String errorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get nutritionFactsUpdated => 'Nutrition facts updated!';

  @override
  String get scanBarcodeTitle => 'Scan Barcode';

  @override
  String get mealDetailsTitle => 'Meal Details';

  @override
  String get aiNutritionAnalysisTitle => 'AI Nutrition Analysis';

  @override
  String get aiDescriptionAnalysisTitle => 'Describe Meal With AI';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get aiPoweredNutritionAnalysis => 'AI-Powered Nutrition Analysis';

  @override
  String get aiAnalysisDescription =>
      'Upload a photo of your meal and let our AI analyze its nutritional content instantly';

  @override
  String get whatAiCanIdentify => 'What our AI can identify:';

  @override
  String get foodIdentification => 'Food identification';

  @override
  String get portionEstimation => 'Portion estimation';

  @override
  String get calorieCalculation => 'Calorie calculation';

  @override
  String get macroMicronutrients => 'Macro & micronutrients';

  @override
  String get ingredientBreakdown => 'Ingredient breakdown';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get takePhoto => 'Take a Photo';

  @override
  String get aiTipMessage =>
      'Tip: For best results, take a clear photo with good lighting and include the entire meal in frame.';

  @override
  String get failedToAnalyzeImage => 'Failed to analyze image';

  @override
  String get calories => 'Calories';

  @override
  String get carbohydrates => 'Carbohydrates';

  @override
  String get fiber => 'Fiber';

  @override
  String get protein => 'Protein';

  @override
  String get fat => 'Fat';

  @override
  String get sugar => 'Sugar';

  @override
  String get water => 'Water';

  @override
  String get vitaminA => 'Vitamin A';

  @override
  String get vitaminD => 'Vitamin D';

  @override
  String get vitaminE => 'Vitamin E';

  @override
  String get vitaminK => 'Vitamin K';

  @override
  String get vitaminC => 'Vitamin C';

  @override
  String get thiamin => 'Thiamin';

  @override
  String get riboflavin => 'Riboflavin';

  @override
  String get niacin => 'Niacin';

  @override
  String get pantothenicAcid => 'Pantothenic Acid';

  @override
  String get vitaminB6 => 'Vitamin B6';

  @override
  String get folate => 'Folate';

  @override
  String get vitaminB12 => 'Vitamin B12';

  @override
  String get choline => 'Choline';

  @override
  String get calcium => 'Calcium';

  @override
  String get chlorine => 'Chlorine';

  @override
  String get copper => 'Copper';

  @override
  String get fluoride => 'Fluoride';

  @override
  String get iodine => 'Iodine';

  @override
  String get iron => 'Iron';

  @override
  String get magnesium => 'Magnesium';

  @override
  String get manganese => 'Manganese';

  @override
  String get molybdenum => 'Molybdenum';

  @override
  String get phosphorus => 'Phosphorus';

  @override
  String get potassium => 'Potassium';

  @override
  String get selenium => 'Selenium';

  @override
  String get sodium => 'Sodium';

  @override
  String get zinc => 'Zinc';

  @override
  String get loadingCredits => 'Loading credits...';

  @override
  String get insufficientCredits => 'Insufficient Credits';

  @override
  String insufficientCreditsMessage(Object credits) {
    return 'You need at least 1 credit to use AI analysis. You currently have $credits credits. You can earn more credits by watching ads in the Settings page.';
  }

  @override
  String get ok => 'OK';

  @override
  String get goToSettings => 'Go to Settings';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get loading => 'Loading...';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get chinese => '中文';

  @override
  String get arabic => 'العربية';

  @override
  String get hindi => 'हिंदी';

  @override
  String get languageChangedSuccessfully => 'Language changed successfully!';
}
