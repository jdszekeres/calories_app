// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get aiCredits => 'एआई क्रेडिट';

  @override
  String get aiCreditDescription =>
      'एआई फूड एनालिसिस का उपयोग करने के लिए आपको एआई क्रेडिट की आवश्यकता है। विज्ञापन देखकर 5 और पाने के लिए यहां क्लिक करें।';

  @override
  String creditCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count क्रेडिट',
      one: '1 क्रेडिट',
      zero: 'कोई क्रेडिट नहीं',
    );
    return '$_temp0';
  }

  @override
  String get calorieGoals => 'कैलोरी लक्ष्य';

  @override
  String get macroNutrientGoals => 'मैक्रो न्यूट्रिएंट लक्ष्य';

  @override
  String get vitaminGoals => 'विटामिन लक्ष्य';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get setGoal => 'लक्ष्य निर्धारित करें';

  @override
  String get invalidInput => 'अमान्य इनपुट';

  @override
  String get fillForm => 'कृपया सभी फॉर्म फील्ड भरें।';

  @override
  String get dailyGoals => 'दैनिक लक्ष्य';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get noGoalsFound =>
      'कोई लक्ष्य नहीं मिला। कृपया सेटिंग्स में अपना लक्ष्य निर्धारित करें।';

  @override
  String get myMeals => 'मेरे भोजन';

  @override
  String get noMealsFound => 'कोई भोजन नहीं मिला। कृपया कुछ भोजन जोड़ें।';

  @override
  String get addMeal => 'भोजन जोड़ें';

  @override
  String get reAddMeal => 'भोजन फिर से जोड़ें';

  @override
  String get goal => 'लक्ष्य';

  @override
  String get enterGoal => 'अपना लक्ष्य दर्ज करें';

  @override
  String setGoalFor(Object foodType) {
    return '$foodType के लिए लक्ष्य निर्धारित करें';
  }

  @override
  String get welcomeBack => 'वापसी पर स्वागत है!';

  @override
  String get username => 'उपयोगकर्ता नाम';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get next => 'अगला';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get step1_2 => 'चरण 1/2';

  @override
  String get step2_2 => 'चरण 2/2';

  @override
  String get tellUs => 'हमें अपने बारे में और बताएं';

  @override
  String get tellUsExplain =>
      'यह हमें आपके दैनिक कैलोरी लक्ष्यों की गणना करने में मदद करता है';

  @override
  String get age => 'उम्र';

  @override
  String get useImperial => 'इंपीरियल इकाइयों का उपयोग करें';

  @override
  String get weight => 'वजन (किग्रा)';

  @override
  String get weightImperial => 'वजन (पाउंड)';

  @override
  String get height => 'ऊंचाई (सेमी)';

  @override
  String get heightImperial => 'ऊंचाई (इंच)';

  @override
  String get sex => 'लिंग';

  @override
  String get male => 'पुरुष';

  @override
  String get female => 'महिला';

  @override
  String get activityLevel => 'गतिविधि स्तर';

  @override
  String get sedentary => 'गतिहीन (कम या कोई व्यायाम नहीं)';

  @override
  String get lightlyActive => 'हल्का सक्रिय (हल्का व्यायाम 1-3 दिन/सप्ताह)';

  @override
  String get moderatelyActive => 'मध्यम सक्रिय (मध्यम व्यायाम 3-5 दिन/सप्ताह)';

  @override
  String get veryActive => 'बहुत सक्रिय (कठिन व्यायाम 6-7 दिन/सप्ताह)';

  @override
  String get extraActive =>
      'अतिरिक्त सक्रिय (बहुत कठिन व्यायाम, शारीरिक काम, या दिन में दो बार प्रशिक्षण)';

  @override
  String get completeSignUp => 'साइन अप पूरा करें';

  @override
  String get back => 'वापस';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get noAccount => 'खाता नहीं है? साइन अप करें';

  @override
  String get tryAnon => 'बिना खाते के कोशिश करें';

  @override
  String get downloadApp => 'ऐप डाउनलोड करें';

  @override
  String get webAdvertisementTitle => 'हम वेब पर विज्ञापन प्रदान नहीं कर सकते';

  @override
  String get mobileAdvertisementTitle => 'कोई विज्ञापन उपलब्ध नहीं';

  @override
  String get useMobileAppMessage =>
      'विज्ञापन देखने के लिए कृपया मोबाइल ऐप का उपयोग करें';

  @override
  String get supportMeMessage =>
      'या BuyMeACoffee के माध्यम से मेरा समर्थन करने पर विचार करें।';

  @override
  String get supportMe => 'मेरा समर्थन करें';

  @override
  String get appTitle => 'कैलोरी ट्रैकर';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है? साइन इन करें';

  @override
  String get creatingAnon => 'गुमनाम खाता बनाना';

  @override
  String get creatingAnonExplain =>
      'हमें अभी भी आपकी प्रोफाइल सेट अप करने और आपके लक्ष्यों की गणना करने के लिए कुछ जानकारी चाहिए।';

  @override
  String get pleaseFillAllFields => 'कृपया सभी फील्ड भरें';

  @override
  String get invalidEmail => 'कृपया एक मान्य ईमेल पता दर्ज करें';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get invalidAge => 'कृपया एक मान्य उम्र दर्ज करें';

  @override
  String get invalidWeight => 'कृपया एक मान्य वजन दर्ज करें';

  @override
  String get invalidHeight => 'कृपया एक मान्य ऊंचाई दर्ज करें';

  @override
  String errorLoadingData(Object message) {
    return 'डेटा लोड करने में त्रुटि: $message';
  }

  @override
  String errorLoadingGoals(Object message) {
    return 'लक्ष्य लोड करने में त्रुटि: $message';
  }

  @override
  String get editNutritionFacts => 'पोषण तथ्य संपादित करें';

  @override
  String get nutritionFacts => 'पोषण तथ्य';

  @override
  String get servingSize => 'परोसने का आकार';

  @override
  String servingSizeValue(Object servingSize) {
    return 'परोसने का आकार $servingSize';
  }

  @override
  String youAteServings(Object servings) {
    return 'आपने $servings भाग खाए';
  }

  @override
  String get yourIntake => 'आपका सेवन';

  @override
  String get ingredients => 'सामग्री';

  @override
  String get save => 'सेव करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get general => 'सामान्य';

  @override
  String get homePageWidgets => 'होम पेज विजेट';

  @override
  String get selectHomeWidgetsDescription =>
      'चुनें कि होमस्क्रीन पर कौन से लक्ष्य दिखाई दें';

  @override
  String get selectHomePageWidgets => 'होम पेज विजेट चुनें';

  @override
  String get homePageWidgetsUpdated => 'होम पेज विजेट सफलतापूर्वक अपडेट किए गए';

  @override
  String get nutritionGoals => 'पोषण लक्ष्य';

  @override
  String get updateHealthInformation => 'स्वास्थ्य जानकारी अपडेट करें';

  @override
  String get resetNutritionGoals => 'पोषण लक्ष्य रीसेट करें';

  @override
  String get nutritionGoalsReset => 'पोषण लक्ष्य सफलतापूर्वक रीसेट किए गए';

  @override
  String get account => 'खाता';

  @override
  String get createAccountDesc =>
      'हमारे ऐप का उपयोग जारी रखना चाहते हैं? अपना डेटा सेव करने के लिए खाता बनाएं।';

  @override
  String get signOut => 'साइन आउट करें';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get delete => 'हटाएं';

  @override
  String get deleteAccountConfirmTitle => 'खाता हटाएं';

  @override
  String get deleteAccountConfirmBody =>
      'क्या आप वाकई अपना खाता हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';

  @override
  String get accountDeleted => 'खाता सफलतापूर्वक हटाया गया';

  @override
  String get metric => 'मेट्रिक';

  @override
  String get imperial => 'इंपीरियल';

  @override
  String get years => 'वर्ष';

  @override
  String get saving => 'सेव हो रहा है...';

  @override
  String get updateHealthInformationSuccess =>
      'स्वास्थ्य जानकारी सफलतापूर्वक अपडेट की गई!';

  @override
  String get couldNotLoadUserProfile => 'उपयोगकर्ता प्रोफाइल लोड नहीं हो सका';

  @override
  String errorSavingHealthInformation(Object message) {
    return 'स्वास्थ्य जानकारी सेव करने में त्रुटि: $message';
  }

  @override
  String get createAccountTagline =>
      'अपना डेटा सेव करें और डिवाइसों में सिंक करें';

  @override
  String get createAccountSuccess => 'खाता सफलतापूर्वक बनाया गया';

  @override
  String get unitKg => 'किग्रा';

  @override
  String get unitLbs => 'पाउंड';

  @override
  String get unitCm => 'सेमी';

  @override
  String get unitFt => 'फुट';

  @override
  String get unitIn => 'इंच';

  @override
  String get unitKcal => 'किलो कैलोरी';

  @override
  String get searchFoodTitle => 'भोजन खोजें';

  @override
  String get searchForProducts => 'उत्पादों की खोज करें';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला';

  @override
  String errorSearchingProducts(Object message) {
    return 'उत्पादों की खोज में त्रुटि: $message';
  }

  @override
  String errorWithMessage(Object message) {
    return 'त्रुटि: $message';
  }

  @override
  String get nutritionFactsUpdated => 'पोषण तथ्य अपडेट किए गए!';

  @override
  String get scanBarcodeTitle => 'बारकोड स्कैन करें';

  @override
  String get mealDetailsTitle => 'भोजन विवरण';

  @override
  String get aiNutritionAnalysisTitle => 'एआई पोषण विश्लेषण';

  @override
  String get aiDescriptionAnalysisTitle => 'एआई के साथ भोजन का वर्णन करें';

  @override
  String get noImageSelected => 'कोई छवि चयनित नहीं';

  @override
  String get aiPoweredNutritionAnalysis => 'एआई-संचालित पोषण विश्लेषण';

  @override
  String get aiAnalysisDescription =>
      'अपने भोजन की फोटो अपलोड करें और हमारे एआई को तुरंत इसकी पोषण सामग्री का विश्लेषण करने दें';

  @override
  String get whatAiCanIdentify => 'हमारा एआई क्या पहचान सकता है:';

  @override
  String get foodIdentification => 'भोजन पहचान';

  @override
  String get portionEstimation => 'भाग अनुमान';

  @override
  String get calorieCalculation => 'कैलोरी गणना';

  @override
  String get macroMicronutrients => 'मैक्रो और माइक्रो पोषक तत्व';

  @override
  String get ingredientBreakdown => 'घटक विवरण';

  @override
  String get uploadPhoto => 'फोटो अपलोड करें';

  @override
  String get takePhoto => 'फोटो लें';

  @override
  String get aiTipMessage =>
      'सुझाव: सबसे अच्छे परिणामों के लिए, अच्छी रोशनी के साथ स्पष्ट फोटो लें और पूरे भोजन को फ्रेम में शामिल करें।';

  @override
  String get failedToAnalyzeImage => 'छवि का विश्लेषण करने में असफल';

  @override
  String get calories => 'कैलोरी';

  @override
  String get carbohydrates => 'कार्बोहाइड्रेट';

  @override
  String get fiber => 'फाइबर';

  @override
  String get protein => 'प्रोटीन';

  @override
  String get fat => 'वसा';

  @override
  String get sugar => 'चीनी';

  @override
  String get water => 'पानी';

  @override
  String get vitaminA => 'विटामिन ए';

  @override
  String get vitaminD => 'विटामिन डी';

  @override
  String get vitaminE => 'विटामिन ई';

  @override
  String get vitaminK => 'विटामिन के';

  @override
  String get vitaminC => 'विटामिन सी';

  @override
  String get thiamin => 'थायमिन';

  @override
  String get riboflavin => 'राइबोफ्लेविन';

  @override
  String get niacin => 'नियासिन';

  @override
  String get pantothenicAcid => 'पैंटोथेनिक एसिड';

  @override
  String get vitaminB6 => 'विटामिन बी6';

  @override
  String get folate => 'फोलेट';

  @override
  String get vitaminB12 => 'विटामिन बी12';

  @override
  String get choline => 'कोलीन';

  @override
  String get calcium => 'कैल्शियम';

  @override
  String get chlorine => 'क्लोरीन';

  @override
  String get copper => 'तांबा';

  @override
  String get fluoride => 'फ्लोराइड';

  @override
  String get iodine => 'आयोडीन';

  @override
  String get iron => 'आयरन';

  @override
  String get magnesium => 'मैग्नीशियम';

  @override
  String get manganese => 'मैंगनीज';

  @override
  String get molybdenum => 'मोलिब्डेनम';

  @override
  String get phosphorus => 'फास्फोरस';

  @override
  String get potassium => 'पोटेशियम';

  @override
  String get selenium => 'सेलेनियम';

  @override
  String get sodium => 'सोडियम';

  @override
  String get zinc => 'जिंक';

  @override
  String get loadingCredits => 'क्रेडिट लोड हो रहे हैं...';

  @override
  String get insufficientCredits => 'अपर्याप्त क्रेडिट';

  @override
  String insufficientCreditsMessage(Object credits) {
    return 'एआई एनालिसिस का उपयोग करने के लिए आपको कम से कम 1 क्रेडिट की आवश्यकता है। वर्तमान में आपके पास $credits क्रेडिट हैं। आप सेटिंग्स पेज में विज्ञापन देखकर अधिक क्रेडिट कमा सकते हैं।';
  }

  @override
  String get ok => 'ठीक है';

  @override
  String get goToSettings => 'सेटिंग्स पर जाएं';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get english => 'अंग्रेजी';

  @override
  String get spanish => 'स्पेनिश';

  @override
  String get chinese => 'चीनी';

  @override
  String get arabic => 'अरबी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get languageChangedSuccessfully => 'भाषा सफलतापूर्वक बदल दी गई!';
}
