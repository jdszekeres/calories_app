// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aiCredits => 'AI积分';

  @override
  String get aiCreditDescription => '您需要AI积分来使用AI食物分析。点击这里通过观看广告获得5个积分。';

  @override
  String creditCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个积分',
      one: '1个积分',
      zero: '无积分',
    );
    return '$_temp0';
  }

  @override
  String get calorieGoals => '卡路里目标';

  @override
  String get macroNutrientGoals => '宏量营养素目标';

  @override
  String get vitaminGoals => '维生素目标';

  @override
  String get cancel => '取消';

  @override
  String get setGoal => '设定目标';

  @override
  String get invalidInput => '无效输入';

  @override
  String get fillForm => '请填写所有表单字段。';

  @override
  String get dailyGoals => '每日目标';

  @override
  String get retry => '重试';

  @override
  String get noGoalsFound => '未找到目标。请在设置中设定您的目标。';

  @override
  String get myMeals => '我的餐食';

  @override
  String get noMealsFound => '未找到餐食。请添加一些餐食。';

  @override
  String get addMeal => '添加餐食';

  @override
  String get goal => '目标';

  @override
  String get enterGoal => '输入您的目标';

  @override
  String setGoalFor(Object foodType) {
    return '为$foodType设定目标';
  }

  @override
  String get welcomeBack => '欢迎回来！';

  @override
  String get username => '用户名';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get next => '下一步';

  @override
  String get createAccount => '创建账户';

  @override
  String get step1_2 => '第1步/共2步';

  @override
  String get step2_2 => '第2步/共2步';

  @override
  String get tellUs => '告诉我们更多关于您的信息';

  @override
  String get tellUsExplain => '这有助于我们计算您的每日卡路里目标';

  @override
  String get age => '年龄';

  @override
  String get useImperial => '使用英制单位';

  @override
  String get weight => '体重 (公斤)';

  @override
  String get weightImperial => '体重 (磅)';

  @override
  String get height => '身高 (厘米)';

  @override
  String get heightImperial => '身高 (英寸)';

  @override
  String get sex => '性别';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String get activityLevel => '活动水平';

  @override
  String get sedentary => '久坐 (很少或不运动)';

  @override
  String get lightlyActive => '轻度活跃 (每周轻度运动1-3天)';

  @override
  String get moderatelyActive => '中度活跃 (每周中度运动3-5天)';

  @override
  String get veryActive => '高度活跃 (每周高强度运动6-7天)';

  @override
  String get extraActive =>
      'Extra Active (very hard exercise, physical job, or training twice a day)';

  @override
  String get completeSignUp => 'Complete Sign Up';

  @override
  String get back => 'Back';

  @override
  String get signIn => '登录';

  @override
  String get noAccount => 'Don\'t have an account? Sign Up';

  @override
  String get tryAnon => 'Try without an account';

  @override
  String get downloadApp => '下载应用';

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
  String get passwordsDoNotMatch => '密码不匹配。';

  @override
  String get invalidAge => '请输入有效年龄';

  @override
  String get invalidWeight => '请输入有效体重';

  @override
  String get invalidHeight => '请输入有效身高';

  @override
  String errorLoadingData(Object message) {
    return '加载数据时出错：$message';
  }

  @override
  String errorLoadingGoals(Object message) {
    return '加载目标时出错：$message';
  }

  @override
  String get editNutritionFacts => '编辑营养成分';

  @override
  String get nutritionFacts => '营养成分';

  @override
  String get servingSize => '份量';

  @override
  String servingSizeValue(Object servingSize) {
    return '份量大小 $servingSize';
  }

  @override
  String youAteServings(Object servings) {
    return '您吃了 $servings 份';
  }

  @override
  String get yourIntake => '您的摄入量';

  @override
  String get ingredients => '成分';

  @override
  String get save => '保存';

  @override
  String get confirm => '确认';

  @override
  String get settings => '设置';

  @override
  String get general => '通用';

  @override
  String get homePageWidgets => '首页小部件';

  @override
  String get selectHomeWidgetsDescription => '选择哪些目标应显示在主屏幕上';

  @override
  String get selectHomePageWidgets => '选择首页小部件';

  @override
  String get homePageWidgetsUpdated => '首页小部件更新成功';

  @override
  String get nutritionGoals => '营养目标';

  @override
  String get updateHealthInformation => '更新健康信息';

  @override
  String get resetNutritionGoals => '重置营养目标';

  @override
  String get nutritionGoalsReset => '营养目标重置成功';

  @override
  String get account => '账户';

  @override
  String get createAccountDesc => '想继续使用我们的应用？创建账户以保存您的数据。';

  @override
  String get signOut => '退出登录';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get delete => '删除';

  @override
  String get deleteAccountConfirmTitle => '删除账户';

  @override
  String get deleteAccountConfirmBody => '您确定要删除您的账户吗？此操作无法撤销。';

  @override
  String get accountDeleted => '账户删除成功';

  @override
  String get metric => '公制';

  @override
  String get imperial => '英制';

  @override
  String get years => '年';

  @override
  String get saving => '保存中...';

  @override
  String get updateHealthInformationSuccess => '健康信息更新成功！';

  @override
  String get couldNotLoadUserProfile => '无法加载用户配置文件';

  @override
  String errorSavingHealthInformation(Object message) {
    return '保存健康信息时出错：$message';
  }

  @override
  String get createAccountTagline => '保存您的数据并跨设备同步';

  @override
  String get createAccountSuccess => '账户创建成功';

  @override
  String get unitKg => '公斤';

  @override
  String get unitLbs => '磅';

  @override
  String get unitCm => '厘米';

  @override
  String get unitFt => '英尺';

  @override
  String get unitIn => '英寸';

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
  String get calories => '卡路里';

  @override
  String get carbohydrates => '碳水化合物';

  @override
  String get fiber => '纤维';

  @override
  String get protein => '蛋白质';

  @override
  String get fat => '脂肪';

  @override
  String get sugar => '糖';

  @override
  String get water => 'Water';

  @override
  String get vitaminA => '维生素A';

  @override
  String get vitaminD => 'Vitamin D';

  @override
  String get vitaminE => 'Vitamin E';

  @override
  String get vitaminK => 'Vitamin K';

  @override
  String get vitaminC => '维生素C';

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
  String get calcium => '钙';

  @override
  String get chlorine => 'Chlorine';

  @override
  String get copper => 'Copper';

  @override
  String get fluoride => 'Fluoride';

  @override
  String get iodine => 'Iodine';

  @override
  String get iron => '铁';

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
  String get sodium => '钠';

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
  String get loading => '加载中...';

  @override
  String get selectLanguage => '选择语言';

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
  String get languageChangedSuccessfully => '语言更改成功！';
}
