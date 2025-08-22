// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get aiCredits => 'أرصدة الذكاء الاصطناعي';

  @override
  String get aiCreditDescription =>
      'تحتاج إلى أرصدة الذكاء الاصطناعي لاستخدام تحليل الطعام بالذكاء الاصطناعي. انقر هنا للحصول على 5 أرصدة إضافية من خلال مشاهدة إعلان.';

  @override
  String creditCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رصيد',
      one: 'رصيد واحد',
      zero: 'لا توجد أرصدة',
    );
    return '$_temp0';
  }

  @override
  String get calorieGoals => 'أهداف السعرات الحرارية';

  @override
  String get macroNutrientGoals => 'أهداف المغذيات الكبرى';

  @override
  String get vitaminGoals => 'أهداف الفيتامينات';

  @override
  String get cancel => 'إلغاء';

  @override
  String get setGoal => 'تحديد الهدف';

  @override
  String get invalidInput => 'إدخال غير صالح';

  @override
  String get fillForm => 'يرجى ملء جميع حقول النموذج.';

  @override
  String get dailyGoals => 'الأهداف اليومية';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noGoalsFound =>
      'لم يتم العثور على أهداف. يرجى تحديد أهدافك في الإعدادات.';

  @override
  String get myMeals => 'وجباتي';

  @override
  String get noMealsFound => 'لم يتم العثور على وجبات. يرجى إضافة بعض الوجبات.';

  @override
  String get addMeal => 'إضافة وجبة';

  @override
  String get goal => 'الهدف';

  @override
  String get enterGoal => 'أدخل هدفك';

  @override
  String setGoalFor(Object foodType) {
    return 'تحديد هدف لـ $foodType';
  }

  @override
  String get welcomeBack => 'مرحباً بك مرة أخرى!';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get next => 'التالي';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get step1_2 => 'الخطوة 1/2';

  @override
  String get step2_2 => 'الخطوة 2/2';

  @override
  String get tellUs => 'أخبرنا المزيد عن نفسك';

  @override
  String get tellUsExplain =>
      'هذا يساعدنا في حساب أهدافك اليومية للسعرات الحرارية';

  @override
  String get age => 'العمر';

  @override
  String get useImperial => 'استخدام الوحدات الإمبراطورية';

  @override
  String get weight => 'الوزن (كيلوغرام)';

  @override
  String get weightImperial => 'الوزن (رطل)';

  @override
  String get height => 'الطول (سم)';

  @override
  String get heightImperial => 'الطول (بوصة)';

  @override
  String get sex => 'الجنس';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get sedentary => 'خامل (قليل أو لا توجد تمارين)';

  @override
  String get lightlyActive => 'نشط قليلاً (تمارين خفيفة 1-3 أيام/أسبوع)';

  @override
  String get moderatelyActive =>
      'نشط بشكل معتدل (تمارين معتدلة 3-5 أيام/أسبوع)';

  @override
  String get veryActive => 'نشط جداً (تمارين شاقة 6-7 أيام في الأسبوع)';

  @override
  String get extraActive =>
      'نشط للغاية (تمارين شاقة جداً، وظيفة بدنية، أو تدريب مرتين في اليوم)';

  @override
  String get completeSignUp => 'إكمال التسجيل';

  @override
  String get back => 'رجوع';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get noAccount => 'ليس لديك حساب؟ اشترك';

  @override
  String get tryAnon => 'جرب بدون حساب';

  @override
  String get downloadApp => 'تحميل التطبيق';

  @override
  String get webAdvertisementTitle => 'لا يمكننا عرض الإعلانات على الويب';

  @override
  String get mobileAdvertisementTitle => 'لا توجد إعلانات متاحة';

  @override
  String get useMobileAppMessage =>
      'يرجى استخدام تطبيق الهاتف المحمول لعرض الإعلانات';

  @override
  String get supportMeMessage => 'أو فكر في دعمي عبر BuyMeACoffee.';

  @override
  String get supportMe => 'ادعمني';

  @override
  String get appTitle => 'متتبع السعرات الحرارية';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ سجل دخولك';

  @override
  String get creatingAnon => 'إنشاء حساب مجهول';

  @override
  String get creatingAnonExplain =>
      'ما زلنا بحاجة إلى بعض المعلومات لإعداد ملفك الشخصي وحساب أهدافك.';

  @override
  String get pleaseFillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get invalidEmail => 'يرجى إدخال عنوان بريد إلكتروني صالح';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get invalidAge => 'يرجى إدخال عمر صالح';

  @override
  String get invalidWeight => 'يرجى إدخال وزن صالح';

  @override
  String get invalidHeight => 'يرجى إدخال طول صالح';

  @override
  String errorLoadingData(Object message) {
    return 'خطأ في تحميل البيانات: $message';
  }

  @override
  String errorLoadingGoals(Object message) {
    return 'خطأ في تحميل الأهداف: $message';
  }

  @override
  String get editNutritionFacts => 'تحرير حقائق التغذية';

  @override
  String get nutritionFacts => 'حقائق التغذية';

  @override
  String get servingSize => 'حجم الحصة';

  @override
  String servingSizeValue(Object servingSize) {
    return 'حجم الحصة $servingSize';
  }

  @override
  String youAteServings(Object servings) {
    return 'تناولت $servings حصص';
  }

  @override
  String get yourIntake => 'استهلاكك';

  @override
  String get ingredients => 'المكونات';

  @override
  String get save => 'حفظ';

  @override
  String get confirm => 'تأكيد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get general => 'عام';

  @override
  String get homePageWidgets => 'عناصر الصفحة الرئيسية';

  @override
  String get selectHomeWidgetsDescription =>
      'حدد الأهداف التي يجب أن تظهر على الشاشة الرئيسية';

  @override
  String get selectHomePageWidgets => 'حدد عناصر الصفحة الرئيسية';

  @override
  String get homePageWidgetsUpdated => 'تم تحديث عناصر الصفحة الرئيسية بنجاح';

  @override
  String get nutritionGoals => 'أهداف التغذية';

  @override
  String get updateHealthInformation => 'تحديث المعلومات الصحية';

  @override
  String get resetNutritionGoals => 'إعادة تعيين أهداف التغذية';

  @override
  String get nutritionGoalsReset => 'تم إعادة تعيين أهداف التغذية بنجاح';

  @override
  String get account => 'الحساب';

  @override
  String get createAccountDesc =>
      'تريد الاستمرار في استخدام تطبيقنا؟ أنشئ حساباً لحفظ بياناتك.';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get delete => 'حذف';

  @override
  String get deleteAccountConfirmTitle => 'حذف الحساب';

  @override
  String get deleteAccountConfirmBody =>
      'هل أنت متأكد من أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get accountDeleted => 'تم حذف الحساب بنجاح';

  @override
  String get metric => 'متري';

  @override
  String get imperial => 'إمبراطوري';

  @override
  String get years => 'سنوات';

  @override
  String get saving => 'جاري الحفظ...';

  @override
  String get updateHealthInformationSuccess =>
      'تم تحديث المعلومات الصحية بنجاح!';

  @override
  String get couldNotLoadUserProfile => 'لا يمكن تحميل ملف المستخدم الشخصي';

  @override
  String errorSavingHealthInformation(Object message) {
    return 'خطأ في حفظ المعلومات الصحية: $message';
  }

  @override
  String get createAccountTagline => 'احفظ بياناتك ومزامنتها عبر الأجهزة';

  @override
  String get createAccountSuccess => 'تم إنشاء الحساب بنجاح';

  @override
  String get unitKg => 'كغم';

  @override
  String get unitLbs => 'رطل';

  @override
  String get unitCm => 'سم';

  @override
  String get unitFt => 'قدم';

  @override
  String get unitIn => 'بوصة';

  @override
  String get unitKcal => 'سعرة حرارية';

  @override
  String get searchFoodTitle => 'البحث عن الطعام';

  @override
  String get searchForProducts => 'البحث عن المنتجات';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String errorSearchingProducts(Object message) {
    return 'خطأ في البحث عن المنتجات: $message';
  }

  @override
  String errorWithMessage(Object message) {
    return 'خطأ: $message';
  }

  @override
  String get nutritionFactsUpdated => 'تم تحديث حقائق التغذية!';

  @override
  String get scanBarcodeTitle => 'مسح الباركود';

  @override
  String get mealDetailsTitle => 'تفاصيل الوجبة';

  @override
  String get aiNutritionAnalysisTitle => 'تحليل التغذية بالذكاء الاصطناعي';

  @override
  String get noImageSelected => 'لم يتم اختيار صورة';

  @override
  String get aiPoweredNutritionAnalysis => 'تحليل التغذية بالذكاء الاصطناعي';

  @override
  String get aiAnalysisDescription =>
      'ارفع صورة لوجبتك ودع ذكاءنا الاصطناعي يحلل محتواها الغذائي فوراً';

  @override
  String get whatAiCanIdentify => 'ما يمكن لذكاءنا الاصطناعي تحديده:';

  @override
  String get foodIdentification => 'تحديد الطعام';

  @override
  String get portionEstimation => 'تقدير الحصة';

  @override
  String get calorieCalculation => 'حساب السعرات الحرارية';

  @override
  String get macroMicronutrients => 'المغذيات الكبرى والصغرى';

  @override
  String get ingredientBreakdown => 'تفصيل المكونات';

  @override
  String get uploadPhoto => 'رفع صورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get aiTipMessage =>
      'نصيحة: للحصول على أفضل النتائج، التقط صورة واضحة بإضاءة جيدة واشمل الوجبة كاملة في الإطار.';

  @override
  String get failedToAnalyzeImage => 'فشل في تحليل الصورة';

  @override
  String get calories => 'السعرات الحرارية';

  @override
  String get carbohydrates => 'الكربوهيدرات';

  @override
  String get fiber => 'الألياف';

  @override
  String get protein => 'البروتين';

  @override
  String get fat => 'الدهون';

  @override
  String get sugar => 'السكر';

  @override
  String get water => 'الماء';

  @override
  String get vitaminA => 'فيتامين أ';

  @override
  String get vitaminD => 'فيتامين د';

  @override
  String get vitaminE => 'فيتامين هـ';

  @override
  String get vitaminK => 'فيتامين ك';

  @override
  String get vitaminC => 'فيتامين ج';

  @override
  String get thiamin => 'الثيامين';

  @override
  String get riboflavin => 'الريبوفلافين';

  @override
  String get niacin => 'النياسين';

  @override
  String get pantothenicAcid => 'حمض البانتوثينيك';

  @override
  String get vitaminB6 => 'فيتامين ب6';

  @override
  String get folate => 'الفولات';

  @override
  String get vitaminB12 => 'فيتامين ب12';

  @override
  String get choline => 'الكولين';

  @override
  String get calcium => 'الكالسيوم';

  @override
  String get chlorine => 'الكلور';

  @override
  String get copper => 'النحاس';

  @override
  String get fluoride => 'الفلورايد';

  @override
  String get iodine => 'اليود';

  @override
  String get iron => 'الحديد';

  @override
  String get magnesium => 'المغنيسيوم';

  @override
  String get manganese => 'المنغنيز';

  @override
  String get molybdenum => 'الموليبدينوم';

  @override
  String get phosphorus => 'الفوسفور';

  @override
  String get potassium => 'البوتاسيوم';

  @override
  String get selenium => 'السيلينيوم';

  @override
  String get sodium => 'الصوديوم';

  @override
  String get zinc => 'الزنك';

  @override
  String get loadingCredits => 'جاري تحميل الأرصدة...';

  @override
  String get insufficientCredits => 'أرصدة غير كافية';

  @override
  String insufficientCreditsMessage(Object credits) {
    return 'تحتاج إلى رصيد واحد على الأقل لاستخدام تحليل الذكاء الاصطناعي. لديك حالياً $credits رصيد. يمكنك كسب المزيد من الأرصدة من خلال مشاهدة الإعلانات في صفحة الإعدادات.';
  }

  @override
  String get ok => 'موافق';

  @override
  String get goToSettings => 'الذهاب إلى الإعدادات';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get chinese => '中文';

  @override
  String get arabic => 'العربية';

  @override
  String get languageChangedSuccessfully => 'تم تغيير اللغة بنجاح!';
}
