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
  String get reAddMeal => '重新添加餐食';

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
  String get extraActive => '超级活跃 (非常高强度运动，体力工作，或一天两次训练)';

  @override
  String get completeSignUp => '完成注册';

  @override
  String get back => '返回';

  @override
  String get signIn => '登录';

  @override
  String get noAccount => '没有账户？注册';

  @override
  String get tryAnon => '无账户试用';

  @override
  String get downloadApp => '下载应用';

  @override
  String get webAdvertisementTitle => '我们无法在网页上提供广告';

  @override
  String get mobileAdvertisementTitle => '没有可用的广告';

  @override
  String get useMobileAppMessage => '请使用移动应用观看广告';

  @override
  String get supportMeMessage => '或考虑通过 BuyMeACoffee 支持我。';

  @override
  String get supportMe => '支持我';

  @override
  String get appTitle => '卡路里追踪器';

  @override
  String get alreadyHaveAccount => '已有账户？登录';

  @override
  String get creatingAnon => '创建匿名账户';

  @override
  String get creatingAnonExplain => '我们仍需要一些信息来设置您的个人资料并计算您的目标。';

  @override
  String get pleaseFillAllFields => '请填写所有字段';

  @override
  String get invalidEmail => '请输入有效的邮箱地址';

  @override
  String get passwordTooShort => '密码必须至少6个字符';

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
  String get servingCount => '份数';

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
  String get unitKcal => '千卡';

  @override
  String get searchFoodTitle => '搜索食物';

  @override
  String get searchForProducts => '搜索产品';

  @override
  String get noResultsFound => '未找到结果';

  @override
  String errorSearchingProducts(Object message) {
    return '搜索产品时出错：$message';
  }

  @override
  String errorWithMessage(Object message) {
    return '错误：$message';
  }

  @override
  String get nutritionFactsUpdated => '营养成分已更新！';

  @override
  String get scanBarcodeTitle => '扫描条形码';

  @override
  String get mealDetailsTitle => '餐食详情';

  @override
  String get aiNutritionAnalysisTitle => 'AI营养分析';

  @override
  String get aiDescriptionAnalysisTitle => '用AI描述餐食';

  @override
  String get noImageSelected => '未选择图片';

  @override
  String get aiPoweredNutritionAnalysis => 'AI驱动的营养分析';

  @override
  String get aiAnalysisDescription => '上传您餐食的照片，让我们的AI立即分析其营养成分';

  @override
  String get whatAiCanIdentify => '我们的AI可以识别：';

  @override
  String get foodIdentification => '食物识别';

  @override
  String get portionEstimation => '份量估算';

  @override
  String get calorieCalculation => '卡路里计算';

  @override
  String get macroMicronutrients => '宏量和微量营养素';

  @override
  String get ingredientBreakdown => '成分分解';

  @override
  String get uploadPhoto => '上传照片';

  @override
  String get takePhoto => '拍照';

  @override
  String get aiTipMessage => '提示：为获得最佳效果，请在良好光线下拍摄清晰照片，并将整个餐食包含在画面中。';

  @override
  String get failedToAnalyzeImage => '图片分析失败';

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
  String get water => '水';

  @override
  String get vitaminA => '维生素A';

  @override
  String get vitaminD => '维生素D';

  @override
  String get vitaminE => '维生素E';

  @override
  String get vitaminK => '维生素K';

  @override
  String get vitaminC => '维生素C';

  @override
  String get thiamin => '硫胺素';

  @override
  String get riboflavin => '核黄素';

  @override
  String get niacin => '烟酸';

  @override
  String get pantothenicAcid => '泛酸';

  @override
  String get vitaminB6 => '维生素B6';

  @override
  String get folate => '叶酸';

  @override
  String get vitaminB12 => '维生素B12';

  @override
  String get choline => '胆碱';

  @override
  String get calcium => '钙';

  @override
  String get chlorine => '氯';

  @override
  String get copper => '铜';

  @override
  String get fluoride => '氟';

  @override
  String get iodine => '碘';

  @override
  String get iron => '铁';

  @override
  String get magnesium => '镁';

  @override
  String get manganese => '锰';

  @override
  String get molybdenum => '钼';

  @override
  String get phosphorus => '磷';

  @override
  String get potassium => '钾';

  @override
  String get selenium => '硒';

  @override
  String get sodium => '钠';

  @override
  String get zinc => '锌';

  @override
  String get loadingCredits => '加载积分中...';

  @override
  String get insufficientCredits => '积分不足';

  @override
  String insufficientCreditsMessage(Object credits) {
    return '您需要至少1个积分来使用AI分析。您目前有$credits个积分。您可以在设置页面观看广告来获得更多积分。';
  }

  @override
  String get ok => '确定';

  @override
  String get goToSettings => '前往设置';

  @override
  String get tryAgain => '重试';

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

  @override
  String get onboardingWelcome => '欢迎使用卡路里追踪器专业版！';

  @override
  String get onboardingCalorieCircle => '这显示您的每日卡路里进度。全天跟踪您的卡路里进度。';

  @override
  String get onboardingNutrientBars => '这些进度条显示您对某些宏量营养素的摄入量。您可以在设置中自定义显示哪些条。';

  @override
  String get onboardingNutrientTitle => '营养素进度';

  @override
  String get onboardingNutrientDescription =>
      '这些进度条显示您全天对蛋白质、碳水化合物和脂肪的宏量营养素摄入量。';

  @override
  String get onboardingHomeTitle => '主页';

  @override
  String get onboardingHomeDescription => '在这里查看您的每日卡路里和营养进度。';

  @override
  String get onboardingGoalsTitle => '目标页面';

  @override
  String get onboardingGoalsDescription => '在这里查看您的所有目标和每日进度。';

  @override
  String get onboardingAddTitle => '记录您的餐食';

  @override
  String get onboardingAddDescription =>
      '您可以在这里使用条形码、搜索、AI图像和AI餐食描述来记录餐食。您可获得10个免费AI积分，然后可以观看广告获得更多。';

  @override
  String get onboardingListTitle => '餐食列表';

  @override
  String get onboardingListDescription => '在这里查看所有记录的餐食。';

  @override
  String get onboardingSettingsTitle => '设置';

  @override
  String get onboardingSettingsDescription => '获取AI积分、自定义主页，并在这里管理您的账户。';

  @override
  String get skipOnboarding => '跳过';

  @override
  String get resetOnboarding => '重新观看教程';
}
